<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="Quiz.css">
    <title>Document</title>
</head>
<body>
    <div class="app">
        <h1>Simple Quiz</h1>
        <div class="quiz">
            <h2 id="question">Question goes here</h2>
            <div id="answer-buttons">
                <button class="btn">Answer 1</button>
                <button class="btn">Answer 2</button>
                <button class="btn">Answer 3</button>
                <button class="btn">Answer 4</button>
            </div>
            <button id="next-btn">Next</button>
        </div>
    </div>
       
    



    <script src="Quiz.js"></script>
</body>
</html>


*{
    margin: 0;
    padding: 0;
    font-family: sans-serif;
    box-sizing: border-box;
}
body{
    background: #001e4d;

}
.app{
    background: white;
    width: 90%;
    max-width: 600px;
    margin: 100px auto 0;
    border-radius: 10px;
    padding: 30px;
}
.app h1{
    font-size: 25px;
    color: #001e4d;
    border-bottom: 1px solid #333;
    padding-bottom: 30px;
    font-weight: 600;
}
.quiz{
    padding: 20px 0;
}
.quiz h2{
    font-size: 18px;
    color: #001e4d;
    font-weight: 600;
}
.btn{
    background: #fff;
    color: #222;
    font-weight: 500;
    width: 100%;
    border: 1px solid #222;
    margin: 10px 0;
    padding: 10px;
    border-radius: 4px;
    cursor: pointer;
    text-align: left;
    transition: all 0.3s;
    
}   
    
.btn:hover:not([disabled]){
    color: #fff;
    background: #222;
}
.btn:disabled{
    cursor: no-drop;
}
#next-btn{
    background: #001e4d;
    color: #fff;
    font-weight: 500;
    padding: 10px;
    width: 150px;
    border-radius: 4px;
    margin: 20px auto 0;
    cursor: pointer;
    border: 0;
    display: none;
}
.correct{
    background: #9aeabc;
}
.incorrect{
    background: #ff9393;
}


const questions = [
    {
        question: "Which is the largest animal in the world?",
        answers: [
            {text: "Shark", correct:false},
            {text: "Blue whale", correct:true},
            {text: "Elephant", correct:false},
            {text: "Giraff", correct:false},
        ]
    },
    {
        question: "Which is the smallest country in the world?",
        answers: [
            {text: "Vatican City", correct:true},
            {text: "Bhutan", correct:false},
            {text: "Nepal", correct:false},
            {text: "Srilanka", correct:false},
        ]
    },
    {
        question: "Which is the largest desert in the world?",
        answers: [
            {text: "kalhari", correct:false},
            {text: "Gobi", correct:false},
            {text: "Sahara", correct:false},
            {text: "Atlantica", correct:true},
        ]
    },
    {
        question: "Which is the smallest country in the world?",
        answers: [
            {text: "Asia", correct:false},
            {text: "Australia", correct:true},
            {text: "Arctica", correct:false},
            {text: "Africa", correct:false},
        ]
    },
];

const questionElement = document.getElementById("question");
const answerButtons = document.getElementById("answer-buttons");
const nextButton = document.getElementById("next-btn");

let currentQuestionIndex = 0;
let score = 0 ;

function startQuiz(){
    currentQuestionIndex = 0;
    score = 0;
    nextButton.innerHTML = "Next" ; 
    showQuestion();
}

function showQuestion(){
    resetStaet();
    let currentQuestion = questions[currentQuestionIndex];
    let questionNo = currentQuestionIndex + 1 ;
    questionElement.innerHTML = questionNo + ". " + currentQuestion.question;

    currentQuestion.answers.forEach(answer => {
        const button = document.createElement("button");
        button.innerHTML = answer.text;
        button.classList.add("btn");
        answerButtons.appendChild(button);
        if(answer.correct){
            button.dataset.correct = answer.correct;
        }
        button.addEventListener("click", selectAnswer);
    });
}

function resetStaet(){
    nextButton.style.display = "none";
    while(answerButtons.firstChild){
        answerButtons.removeChild(answerButtons.firstChild);
    }
}

function selectAnswer(e){
    const selectedBtn = e.target;
    const isCorrect = selectedBtn.dataset.correct === "true";
    if(isCorrect){
        selectedBtn.classList.add("correct");
        score++;

    }else{
        selectedBtn.classList.add("incorrect");
    }
    Array.from(answerButtons.children).forEach(button =>{
        if(button.dataset.correct === "true"){
            button.classList.add("correct");
        }
        button.disabled = true;
    });
    nextButton.style.display = "block";
}

function showScore(){
    resetStaet();
    questionElement.innerHTML = `You scored ${score} out of ${questions.length}!`;
    nextButton.innerHTML = "play again";
    nextButton.style.display ="block";
}

function handleNextButton(){
    currentQuestionIndex++;
    if(currentQuestionIndex < questions.length){
        showQuestion();
    }else{
        showScore();
    }
}

nextButton.addEventListener("click", ()=>{
    if(currentQuestionIndex < questions.length){
        handleNextButton();
    }else{
        startQuiz();
    }
})

startQuiz();
