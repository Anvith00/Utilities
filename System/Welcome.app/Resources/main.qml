import QtQuick 2.2
import QtQuick.Controls 2.15
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0
import QtMultimedia 5.15
import QtQuick.Shapes 1.4


ApplicationWindow {

    // Instantiate a Python object;
    // see 'qmlRegisterType' in the Python file that is using this qml
    function preloadDesktop() {
        return Qt.createQmlObject("import Service 1.0; Desktop {}", window, "Desktop");
    }
    function showWizard() {
        return Qt.createQmlObject("import Service 1.0; Wizard {}", window, "Wizard");
    }


    function smoothDisappear() {

        shapeAnim.running = true;
        skipButton.opacity = 0;
        // ApplicationWindow.opacity = 0;
        welcome.shallContinue = false;
        // window.color = "#00000000"; // ARGB fully transparent


        music.volume = 0.0;

        wallpaper.width = window.width;
        wallpaper.height = window.height;
        wallpaper.x = 0;
        wallpaper.y = 0;

        hello.width = window.width;
        hello.height = window.height;
        hello.x = 0;
        hello.y = 0;
        preloadDesktop();
        // For a smooth transition


        // wallpaper.opacity = 1;
        // hello.opacity = 1;

    }

    function reset() {
        if (welcome.shallContinue != true) {
            return;
        }
        var welcomeTexts = [
            'Welcome',
            'Willkommen',
            'Bienvenue',
            'Benvenuto',
            'Bienvenido',
            'ようこそ',
            'Mabuhay',
            'Välkommen',
            'Добро пожаловать',
            'Hoş geldiniz',
            'Bonvenon',
            '歡迎'
        ];
        var welcomeText = welcomeTexts[Math.floor(Math.random() * welcomeTexts.length)];
        welcome.nextText = welcome.nextText + 1;
        if (welcome.nextText > welcomeTexts.length - 1) {
            smoothDisappear();
            return;
            // welcome.nextText = 0;
        }
        // console.log(welcomeText)
        welcome.text = welcomeTexts[welcome.nextText];
        welcome.x = window.width;
        welcome.opacity = 0.5;
        welcomeBlurAnimation.stop();
        welcomeBlur.length = 30;
        welcomeBlurAnimation.start();
        welcomeMovement.start();
    }

    id : window
    visible : true
    width : Screen.width
    height : Screen.height
    visibility : "FullScreen"
    color : "transparent"
    modality : Qt.WindowStaysOnTopHint

    // NumberAnimation on opacity { to: 1; duration: 1000 }

    SequentialAnimation on color {
        ColorAnimation {
            to : "black";
            duration : 100
        }
        ColorAnimation {
            to : "white";
            duration : 1000
        }
        ColorAnimation {
            to : "black";
            duration : 1000
        }

    }

    Component.onDestruction : {
        console.log("Exiting")
    }


    Item {
        id : back
        Image {
            id : wallpaper
            source : "/usr/local/share/slim/themes/default/background.jpg"
            // source : "Aqua.png"
            width : 0
            height : 0
            // scale: Qt.KeepAspectRatio
            fillMode : Image.PreserveAspectRatio
            clip : true
            x : window.width / 2 - width / 2
            y : window.height / 2 - height / 2
            opacity : 1;
            Behavior on opacity {
                NumberAnimation {
                    duration : 3000;
                    easing.type : Easing.InCubic;
                    onRunningChanged : if (!running) {
                        // console.log("Wallpaper has faded out");
                        // window.visibility = "Hidden";
                        // showWizard();
                        // window.close();
                    }
                }
            }

            Behavior on width {
                NumberAnimation {
                    duration : 2000;
                    easing.type : Easing.OutCubic;
                    onRunningChanged : if (!running) {
                        // window.opacity = 0;
                        // wallpaper.opacity = 0;
                    }
                }

            }
            Behavior on height {
                NumberAnimation {
                    duration : 2000;
                    easing.type : Easing.OutCubic
                }
            }
            Behavior on x {
                NumberAnimation {
                    duration : 2000;
                    easing.type : Easing.OutCubic
                }
            }
            Behavior on y {
                NumberAnimation {
                    duration : 2000;
                    easing.type : Easing.OutCubic
                }
            }


            Image {
                id : hello
                // source : "hello.png"
                width : 0
                height : 0
                scale : Qt.KeepAspectRatio
                fillMode : Image.PreserveAspectCrop
                clip : true
                x : window.width / 2 - width / 2
                y : window.height / 2 - height / 2
                opacity : 1;

                Shape {

                    width : 325
                    height : 200
                    anchors.centerIn : hello
                    scale : (window.height / 1080)
                    layer.enabled : true
                    layer.smooth : true
                    layer.samples : 16
                    antialiasing: on

                    // layer.textureSize : [40000, 4000]
                    vendorExtensionsEnabled : false

                    ShapePath {
                        id : shapePath
                        strokeWidth : 10
                        strokeColor : "white"
                        capStyle : ShapePath.RoundCap
                        joinStyle : ShapePath.RoundJoin
                        strokeStyle : ShapePath.DashLine
                        dashPattern : [400, 400]
                        fillColor : "transparent"
                        startX : 0
                        startY : 0


                        PathSvg {
                            path : ` M 26.816767,36.748271 C 43.203424,67.240957 66.474145,0.31812069 55.270041,32.476855 32.265545,98.505836 29.893572,143.91569 29.893572,143.91569 c 0,0 4.58505,-70.596115 33.845596,-70.596115 29.260591,0 -7.777127,69.109905 17.759383,71.339255 C 107.03503,146.88818 149.25942,78.527398 122.65893,77.041175 96.058441,75.554951 85.096643,140.94325 120.74129,143.1726 156.38598,145.40195 207.35821,31.603066 175.96961,28.630598 144.581,25.65813 143.41473,139.457 175.33529,142.42948 c 31.92063,2.97247 85.36058,-115.66477 52.90796,-117.894121 -32.45261,-2.229351 -35.74697,113.798871 -2.23032,114.541991 21.28041,-1.48624 17.21663,-66.50088 44.88117,-65.014637 39.70208,3.309454 20.43206,76.844967 -7.41485,67.623637 -21.30785,-7.62146 -19.59447,-69.101693 7.53806,-67.61545 19.64913,2.562291 33.14886,28.34421 39.03973,9.71025 `
                        }

                    }

                    NumberAnimation {
                        id : shapeAnim
                        target : shapePath
                        property : "dashOffset"
                        duration : 12000
                        easing.type : Easing.InOutQuad
                        running : false
                        from : 400
                        to : 0
                        // loops: Animation.Infinite
                    }

                }


                Behavior on opacity {
                    NumberAnimation {
                        duration : 3000;
                        easing.type : Easing.InCubic;
                        onRunningChanged : if (!running) {
                            console.log("Wallpaper has faded out");
                            window.visibility = "Hidden";
                            showWizard();
                            window.close();
                        }
                    }
                }

                Behavior on width {


                    PauseAnimation {
                        running : true;
                        duration : 2000;
                        
                        onRunningChanged : if (!running) {
                            window.color = "#00000000";
                            welcomeShadow.color = "transparent";

                        }

                    }

                    PauseAnimation {
                        running : true;
                        duration : 6000;
                        onRunningChanged : if (!running) {
                            wallpaper.opacity = 1;
                            hello.opacity = 1;
                            wallpaper.opacity = 0;
                            hello.opacity = 0;

                        }

                    }

                    NumberAnimation {
                        duration : 2000;
                        easing.type : Easing.OutCubic;
                        onRunningChanged : if (!running) {}
                    }

                }
                Behavior on height {
                    NumberAnimation {
                        duration : 2000;
                        easing.type : Easing.OutCubic
                    }
                }
                Behavior on x {
                    NumberAnimation {
                        duration : 2000;
                        easing.type : Easing.OutCubic
                    }
                }
                Behavior on y {
                    NumberAnimation {
                        duration : 2000;
                        easing.type : Easing.OutCubic
                    }
                }
            }


        }
    }

    Audio { // Could probably play video just as well...
        id : music
        autoPlay : true
        // loops: Audio.Infinite; 
        source : "pamgaea-by-kevin-macleod-from-filmmusic-io.ogg"
        volume : 1.0
        Behavior on volume {
            NumberAnimation {
                duration : 15000;
                easing.type : Easing.OutCubic
            }
        }
    }

    Item {
        Text {
            id : welcome
            renderType : Text.NativeRendering
            text : "Welcome"
            font.family : "Nimbus Sans"
            font.pixelSize : window.height / 8
            color : "white"
            property int nextText // Allow a custom property
            nextText : 0
            property bool shallContinue // Allow a custom property
            shallContinue : true
            x : window.width
            y : window.height / 2 - height / 2
            opacity : 1

            Behavior on opacity {
                NumberAnimation {
                    duration : 3000;
                    easing.type : Easing.OutCubic
                }
            }

            SequentialAnimation on x {
                id: welcomeMovement;
                NumberAnimation {
                    to : window.width / 2 - welcome.width / 2;
                    duration : 1000;
                    easing.type : Easing.OutQuad;
                }
                NumberAnimation {
                    to : 0 - welcome.width;
                    duration : 1000;
                    easing.type : Easing.InQuad;
                }
                onRunningChanged: if (!running) 
                    reset();
                


            }
        }

        DirectionalBlur {
            id : welcomeBlur
            anchors.fill : welcome
            source : welcome
            samples : 30
            length : 30
            angle : 90
            // transparentBorder : true
            SequentialAnimation on length {
                id: welcomeBlurAnimation;
                NumberAnimation {
                    to : 0;
                    duration : 1500;
                    easing.type : Easing.InQuad;
                }
                NumberAnimation {
                    to : 30;
                    duration : 1500;
                    easing.type : Easing.OutQuad;
                }
            }
        }


        DropShadow {
            id : welcomeShadow
            anchors.fill : welcome
            horizontalOffset : 3
            verticalOffset : 0
            radius : 20.0
            samples : 17
            color : "black"
            source : welcome
        }
    }


    RoundButton {
        id : skipButton
        text : "   >   "
        width : ApplicationWindow.width / 100
        height : ApplicationWindow.height / 100
        x : window.width / 2 - width / 2
        y : window.height / 1.25
        hoverEnabled : true

        states : State {
            name : "pressed";
            when : skipButton.pressed
            PropertyChanges {
                target : skipButton;
                scale : 3
            }
        }

        transitions : Transition {
            NumberAnimation {
                properties : "scale";
                easing.type : Easing.InOutQuad
            }
        }

        onClicked : smoothDisappear()
        background : Rectangle {
            id : button
            radius : skipButton.radius
            color : "white"
        }
    }

}
