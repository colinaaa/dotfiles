module.exports = {
  defaultBrowser: "Safari",
  handlers: [
    {
      // Open apple.com and example.org urls in Safari
      match: finicky.matchHostnames(["facebook.com", /.*\.facebook\.com$/, "instagram.com", "^localhost$"]),
      browser: "Google Chrome"
    },
    {
      // Open any url including the string "workplace" in Firefox
      match: /workplace/,
      browser: "Google Chrome"
    }
  ]
};
