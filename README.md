# MyPoster

This project introduces how to create a custom poster on PosterBoard. I haven't succeeded yet, and it includes code from the intermediate steps.

I tested it on iOS 17.0.3.

## Installation

`make package` and Install DEB file.

## Notes

If you install the DEB file, MyPosterPlugin will be registered with Launch Services. Then, `-[PRPosterExtensionDefaultDataSource queryControllerDidUpdate:]` will be called in PosterBoard.

Additionally, by looking at `-[PRPosterExtensionDefaultDataSource knownPosterExtensions]`, you can confirm that PosterBoard has automatically loaded MyPosterPlugin.

```
(lldb) po [0x28118e180 knownPosterExtensions]
<__NSFrozenArrayM 0x283129c50>(
<PRPosterExtension: 0x28312a700; prsExtension: <PRSPosterExtension: 0x282a87100; D1C02D8D-88FC-4D6C-901C-E0A6F50D699E; prs_posterExtensionBundleIdentifier: com.pookjw.MyPoster.MyPosterPlugin; prs_localizedName: MyPosterPlugin>
)
```

You can get `PRPosterExtensionDefaultDataSource` reference like this:

1. Set a breakpoint in the `-[_PBFGalleryCollectionViewController viewDidLoad]` method.

2. When the breakpoint is hit, get the memory address of `_PBFGalleryCollectionViewController` using the `po $x0`command.

3. Continue the execution of the PosterBoard process.

4. Pause PosterBoard again at a later point. Use the LLDB command `po [[0xe63108000 dataProvider] extensionProvider]` to obtain a reference to `PRPosterExtensionDefaultDataSource`.

Now you get a reference to `PRPosterExtensionDefaultDataSource`.

## TODO

PosterBoard successfully loads MyPosterPlugin, but it isn't shown in `_PBFPosterGalleryPreviewViewController`. To do this you will need a lot of work.

Also, MyPosterPlugin does not implement PosterKit's protocols. You need to reverse the PosterKit.
