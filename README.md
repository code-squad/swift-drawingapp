# swift-drawingapp
## Step 2

![step2](assets/step2.gif)

각 클라이언트는 서버에 로그인하고 로그인이 성공하면 자신의 도형을 서버로 전송한다. 이후 도형을 수신할 수 있도록 TCP 통신을 시작한다.

#### 의존 방향

모델과 챗클라이언트 사이에 DrawingChatServiceProviding를 두어 의존성을 역전시킨다.

```
DrawingManager -> DrawingChatServiceProviding 프로토콜 <- DrawingChatClient -> TCPManager
```

## Step 1

![picture](assets/picture.png)

### Model

- 빨간색 영역은 오직 좌표에 대한 내용만 처리한다.
- 노란색 영역은 도형의 스타일 및 앱의 기능을 추가한다.

### View / ViewModel

#### Shape ViewModel 및 View

- Shape를 UIView로 표현하며 출력 기능만 담당.

#### Canvas ViewModel 및 View

- Canvas를 UIView로 표현하며 출력기능만 담당.

- 뷰모델에서 Point를 CGPoint로 상호 변환한다.

#### DrawingManager ViewModel 및 View

- 뷰에선 Canvas 뷰를 가지고 있고 뷰모델에선 Canvas 뷰모델을 갖고 있다.
- 입력을 DrawingManager로 전달하며 Canvas 뷰/뷰모델을 사용하여 출력한다.

![step1_animate](assets/step1_animate.gif)

