const functions = require("firebase-functions");
const axios = require("axios");
const express = require("express");
const path = require("path");
const os = require("os");
const fs = require("fs");
const Busboy = require("busboy");

// 환경 변수에서 Whisper API 키 가져오기
const whisperApiKey = functions.config().whisper.apikey;

const openAI = express.Router();

const app = express();

app.use(express.json());
app.use("/", openAI);

exports.openaiAPI = functions.region("asia-northeast3").https.onRequest(app);

const tmpdir = os.tmpdir();

openAI.post("/stt", async (req, res) => {
  const busboy = Busboy({ headers: req.headers });

  const tmpdir = os.tmpdir();

  // This object will accumulate all the fields, keyed by their name
  const fields = {};

  // This object will accumulate all the uploaded files, keyed by their name.
  const uploads = {};

  // This code will process each non-file field in the form.
  busboy.on("field", (fieldname, val) => {
    /**
     *  TODO(developer): Process submitted field values here
     */
    fields[fieldname] = val;
  });

  const fileWrites = [];

  // This code will process each file uploaded.
  busboy.on("file", (fieldname, file, { filename }) => {
    // Note: os.tmpdir() points to an in-memory file system on GCF
    // Thus, any files in it must fit in the instance's memory.
    if (fieldname !== "audio") {
      res.status(400).send("audio 필드가 없습니다.");
      return;
    }

    const filepath = path.join(tmpdir, filename);
    uploads[fieldname] = filepath;

    const writeStream = fs.createWriteStream(filepath);
    file.pipe(writeStream);

    // File was processed by Busboy; wait for it to be written.
    // Note: GCF may not persist saved files across invocations.
    // Persistent files must be kept in other locations
    // (such as Cloud Storage buckets).
    const promise = new Promise((resolve, reject) => {
      file.on("end", () => {
        writeStream.end();
      });
      writeStream.on("close", resolve);
      writeStream.on("error", reject);
    });
    fileWrites.push(promise);
  });

  // Triggered once all uploaded files are processed by Busboy.
  // We still need to wait for the disk writes (saves) to complete.
  busboy.on("finish", async () => {
    await Promise.all(fileWrites);

    try {
      const response = await axios.post(
        "https://api.openai.com/v1/audio/transcriptions",
        {
          file: fs.createReadStream(uploads.audio),
          model: "whisper-1",
        },
        {
          headers: {
            "Content-Type": "multipart/form-data",
            Authorization: `Bearer ${whisperApiKey}`,
          },
        }
      );

      res.send(response.data);
    } catch (error) {
      res.status(400).send(error.message);
    }

    for (const file in uploads) {
      fs.unlinkSync(uploads[file]);
    }
    // functions.logger.info("done", { structuredData: true });
  });

  busboy.end(req.rawBody);
});
