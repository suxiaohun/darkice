document.addEventListener('turbo:load', function(event) {
    var toggleButton = document.getElementById('history-btn');
    var toggleDiv = document.getElementById('history-div');

    toggleButton.addEventListener('click', function(){
        var currDisplay = window.getComputedStyle(toggleDiv).display
        if (currDisplay === 'none') {
            toggleDiv.style.display = 'block';
        }else{
            toggleDiv.style.display = 'none';
        }
    })


    toggleButton.addEventListener('touchstart', function(){
        var currDisplay = window.getComputedStyle(toggleDiv).display
        if (currDisplay === 'none') {
            toggleDiv.style.display = 'block';
        }else{
            toggleDiv.style.display = 'none';
        }
    })
})