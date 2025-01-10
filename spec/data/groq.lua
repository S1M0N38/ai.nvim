local data = {
  {
    res = "4",
    req = {
      model = "llama-3.1-8b-instant",
      messages = {
        { role = "user", content = "what's 2 + 2 ?" },
      },
    },
  },
  {
    res = "print",
    req = {
      model = "llama-3.1-8b-instant",
      messages = {
        { role = "user", content = "Hello world one-liner in Python, just the code." },
      },
    },
  },
  {
    res = "zcUJMXnP2T!xQSL",
    req = {
      model = "llama-3.1-8b-instant",
      messages = {
        { role = "user", content = "Repeat this string once: `zcUJMXnP2T!xQSL`" },
      },
    },
  },
}

return data
