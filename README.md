silverorange Coding Challenge Assessment for Greg Rodrigues
============================================

This is my completed coding challenge as requested.  I did modify the build version to iOS 15 to make it compatible with the newer AttributedString view to handle the Markdown text.  I did go a bit over 4 hours to complete the challenge as I ran into a few bugs that I needed to solve (Markdown, ViewModel observation, & video player challenges).

I did notice an issue with one of the videos provided in the yarn server.  The second video does not play correctly, and when I attempted to download it using the URL via a browser, it returned an error back.  Good news is that the video player does fail without crashing at least.

Due to time constraints, I did not add an show/hide animation for the buttons over the video.  I would like to have added a fade out after 2-3 seconds to allow the buttons to hide, then reappear after tapping the video, but I'm already beyond the time limit and wouldn't feel that to be fair to continue coding.  I last worked with adding a video player 5 years ago, so I'm happy it went as quickly as it did.  Along the same line, I would have liked to add more Unit Tests to handle data verification for video title/url/author/markdown data.
