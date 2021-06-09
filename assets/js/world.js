class Note {
    constructor(note) {
        this.id = note.targetInfo.name;
        this.rating = note.targetInfo.rating;
        this.metadata = note.metadata;
    }
}

var World = {
    loaded: false,
    tracker: null,
    cloudRecognitionService: null,
    timer: 750,
    apiUrl: "https://great-emu-51.loca.lt/notes/",

    init: function initFn() {
        World.createTracker();
    },

    createTracker: function createTrackerFn() {
        World.cloudRecognitionService = new AR.CloudRecognitionService(
            "f25c7edb7907b29897897ff3e95b09b1", 
            "5fefa2afc48140645bbb3a0f", 
            {
                onInitialized: World.trackerLoaded,
                onError: World.onError
            }
        );
    
        World.tracker = new AR.ImageTracker(this.cloudRecognitionService, {
            onError: World.onError
        });
    },

    createAugmentation: function createAugmentationFn() {
        var htmlOverlay = new AR.HtmlDrawable(
            {
                html: "<div class=\"sticky\">" +
                        "<style>" +
                            "@import url('https://fonts.googleapis.com/css2?family=Kalam&display=swap');" +
                            ".sticky {" +
                                "font-size: 30px;" +
                                "filter: drop-shadow(-6px 12px 3px rgba(50, 50, 0, 0.5));" +
                                "width: 100%;" +
                                "height: 100%;" +
                            "}" +
                            ".sticky-content {" +
                                "overflow: scroll;" +
                                "padding: 2% 4%;" +
                                "background: linear-gradient(180deg," +
                                    "rgba(187, 235, 255, 1) 0%," +
                                    "rgba(187, 235, 255, 1) 12%," +
                                    "rgba(170, 220, 241, 1) 75%," +
                                    "rgba(195, 229, 244, 1) 100%);" +
                                "width: 90%;" +
                                "margin: 5%;" +
                                "justify-content: center;" +
                                "align-items: center;" +
                                "font-family: 'Kalam', cursive;" +
                                "clip-path: url(#stickyClip);" +
                            "}" +
                        "</style>" +
                        "<svg width=\"0\" height=\"0\">" +
                            "<defs>" +
                                "<clipPath id=\"stickyClip\" clipPathUnits=\"objectBoundingBox\">" +
                                    "<path d=\"M 0 0 Q 0 0.69, 0.03 0.96 0.03 0.96, 1 0.96 Q 0.96 0.69, 0.96 0 0.96 0, 0 0\" stroke-linejoin=\"round\" stroke-linecap=\"square\" />" +
                                "</clipPath>" +
                            "</defs>" +
                        "</svg>" +
                        "<div class=\"sticky-content\">" +
                            "<h2>" + World.note.metadata.title + "</h2>" +
                            "<p>" + World.note.metadata.content + "</p>" +
                        "</div>" +
                    "</div>"
            }, 
            1
        );
        World.Augmentation = new AR.ImageTrackable(World.tracker, World.note.id, {
            drawables: {
                cam: [htmlOverlay]
            }
        });
    },

    onRecognition: function onRecognitionFn(recognized, response) {
        if (recognized) {
            console.log(response.metadata.id);
            World.note = new Note(response);
            World.getNote();
        } 
        else {
            // Comment following line out for continuous image recognition
            World.showError("Recognition failed, please try again!");
    
            setTimeout(function() {
                var e = document.getElementById('errorMessage');
                e.removeChild(e.firstChild);
            }, World.timer);
        }
    },

    getNote: function getNoteFn() {
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            console.log("GET note: " + World.note.id);
            console.log(this.status);
            console.log(this.response);
            if (this.readyState == 4) {
                if (this.status == 200 || this.status == 201) {
                    console.log("Note found");
                    // Note needs to mach info from api if edited
                    World.note.metadata = JSON.parse(this.response).metadata;
                    console.log("Create augmentation");
                    World.createAugmentation();
                }
                else if (this.status == 0 || this.status == 404) {
                    console.log("Note couldn't be found");
                    World.saveNote();
                }
                else {
                    World.showError("API not good responding");
                }
            }
        };
        xhttp.open("GET", World.apiUrl + World.note.id, true);
        xhttp.send(); 
    },

    saveNote: function saveNote() {
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            console.log("Post note: " + JSON.stringify(World.note));
            console.log(this.status);
            console.log(this.response);
            if (this.readyState == 4) {
                if (this.status == 200 || this.status == 201) {
                    console.log("Note saved");
                    console.log("Create augmentation");
                    World.createAugmentation();
                }
                else if (this.status == 0 || this.status == 404) {
                    console.log("Note couldn't be saved");
                }
                else {
                    World.showError("API not good responding");
                }
            }
        };
        xhttp.open("POST", World.apiUrl, true);
        xhttp.setRequestHeader("Content-type", "application/json; charset=UTF-8");
        xhttp.send(JSON.stringify(World.note)); 
    },

    scan: function scanFn() {
        World.cloudRecognitionService.recognize(this.onRecognition, this.onRecognitionError);
    },

    onRecognitionError: function onRecognitionErrorFn(errorCode, errorMessage) {
        alert("error code: " + errorCode + " error message: " + JSON.stringify(errorMessage));
    },

    onError: function onErrorFn(error) {
        alert(error);
    },

    showError: function showErrorFn(error) {
        document.getElementById('errorMessage').innerHTML = "<div class='errorMessage'>" + error + "</div>";
    },

    trackerLoaded: function trackerLoadedFn() {
        document.getElementById("infoBox").style.display = "table";
        document.getElementById("loadingMessage").style.display = "none";

        // Comment following two lines out for continuous image recognition
        /*World.startContinuousRecognition(World.timer * 2);
        World.showUserInstructions();*/
    },

    startContinuousRecognition: function startContinuousRecognitionFn(interval) {
        World.cloudRecognitionService.startContinuousRecognition(interval, this.onInterruption, this.onRecognition, this.onRecognitionError);
    },

    onInterruption: function onInterruptionFn(suggestedInterval) {
        World.cloudRecognitionService.stopContinuousRecognition();
        World.cloudRecognitionService.startContinuousRecognition(suggestedInterval);
    },
};

World.init();