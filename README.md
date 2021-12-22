# [![publish](https://github.com/ZuYun/pageviewj/actions/workflows/publish.yml/badge.svg)](https://github.com/ZuYun/pageviewj/actions/workflows/publish.yml)![https://pub.dev/packages/pageviewj](https://img.shields.io/badge/pageviewj-0.0.1-blue)

- pub

  ```
  dependencies:
    pageviewj: ^0.0.1
  ```

  

#### PageViewJ.aniBuilder

![flipover](https://raw.githubusercontent.com/ZuYun/pageviewj/main/preview/1.gif)

```
PageViewJ.aniBuilder(
     aniItemBuilder: pageviewAniItem,
)
```





#### RotateTransform

![flipover](https://raw.githubusercontent.com/ZuYun/pageviewj/main/preview/RotateTransform.gif)

```dart
PageViewJ(
     modifier: const Modifier(viewportFraction: .73),
     transform: RotateTransform(),
     itemBuilder: pageViewItem,
)
```



#### StackTransform

![flipover](https://raw.githubusercontent.com/ZuYun/pageviewj/main/preview/StackTransform.gif)

```dart
PageViewJ(
   modifier: const Modifier(viewportFraction: .73,padEnds: false,
                            scrollDirection: Axis.vertical),
   transform: StackTransform(), itemBuilder: pageViewItem,
)
```



### CLipTransform

![flipover](https://raw.githubusercontent.com/ZuYun/pageviewj/main/preview/ClipTransform.gif)

```dart
PageViewJ(
    modifier: const Modifier(scrollDirection: Axis.vertical),
    transform: ClipTransform(),
    itemBuilder: pageViewItem,
),
```



### FlipTransform

![flipover](https://raw.githubusercontent.com/ZuYun/pageviewj/main/preview/FlipTransform.gif)

```dart
PageViewJ(
   modifier: const Modifier(scrollDirection: Axis.horizontal,clipBehavior: Clip.none),
   transform: FlipTransform(),
   itemBuilder: pageViewItem,
)
```

