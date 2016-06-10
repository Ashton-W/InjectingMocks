# InjectingMocks

Content from talk at Melbourne Cocoaheads No. 95 - June 2016   
Video: (https://youtu.be/2JLqld46Bjg?t=1h24m)

Uses submodules:
`git submodule update --init --recursive`

---

- Xcode UI Tests run in a seperate process
- Need network stubs for UI Tests
- Stubs only affect the process you stub in
- 😑

---

- Put stubbing code in a Framework
- Inject it!
- Works outside of tests too

---

Build Phase Script based on my Reveal Build Phase script  
https://gist.github.com/Ashton-W/6db611ac93be2f8bad7f
