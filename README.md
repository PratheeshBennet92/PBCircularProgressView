# PBCircularProgressView
## Overview
PBCircularProgressView is a circular progress view for iOS similar to the app store download progress view. It also has an inbuilt pause/resume button from which you can receive call the button backs. 

![alt text](https://github.com/PratheeshBennet92/PBCircularProgressView/blob/main/PBProgressCircularProgressView.gif)

## Sample usage

### Creating and configuring PBCircularProgressView
```
     let circularProgressBarView = PBCircularProgressView(arcRadius: 20,
                                                     lineWidth: 5,
                                                     circleStrokeColor: .lightGray,
                                                     progressStrokeColor: .red,
                                                     progressAnimationDuration: 0.35)
    view.addSubview(circularProgressBarView)
    circularProgressBarView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    circularProgressBarView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    circularProgressBarView.widthAnchor.constraint(equalToConstant: 40).isActive = true
    circularProgressBarView.heightAnchor.constraint(equalToConstant: 40).isActive = true

```
### Setting progress to PBCircularProgressView
```
    circularProgressBarView.progress = 0.25

```

