import express from "express";
import "dotenv/config"

const app = express();

const PORT = process.env.PORT || 3000;

app.get("/", (req, res)=>{
    res.send("hello world");
})

app.get("/health", (req, res)=>{
    res.send("Healthy");
})

app.listen(PORT, () => {
    console.log(`The server is listening on port: ${PORT}`)
})