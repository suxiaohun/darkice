console.log("......1......haha");

function haha() {
    var el = document.getElementById("validate1");
    if (el) {
        el.addEventListener("click", function () {
            alert("hahhhha")
        });
    }
}

var foo = 'bar';

// setTimeout(() => foo = 'baz', 500);

// console.log(foo)


export {foo}

export {haha}

