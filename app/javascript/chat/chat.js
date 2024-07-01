document.addEventListener('turbo:load', () => {
    var messageTextArea = document.getElementById('message');
    var messageForm = document.getElementById('messageForm');
    messageTextArea.addEventListener('keydown', function(event) {
        if (event.key === "Enter"){
            if (messageTextArea.value !=="" && !event.shiftKey) {
                console.log(111)
                event.preventDefault()
                messageForm.requestSubmit()
                messageTextArea.value = ''
            }else  if (messageTextArea.value === "") {
                event.preventDefault()
            }
            else if(event.shiftKey) {

            }
        }else{

        }
    })

})



