/**
 * Created by gabriella.querales on 12/30/15.
 */
exports.socialProfile= function (subscriber)
{
    console.log ("socialProfile 1")
}

exports.favActors = function (subscriber)
{
    console.log ("favActors...... 4 - long query")
    actorsProf ();
    dummy = [];
    var now = Date.now(), then = now;
    while (then - now < 5000) {
        then = Date.now();
        dummy.push(0);
        if (dummy.length > 100) {
            dummy.splice(0, 10);
        }
    }
}

exports.moviesRated= function (subscriber)
{
    console.log ("moviesRated 2")
    setTimeout(function() {
    }, 1000);
}

exports.ticketsBought= function (subscriber)
{
    console.log ("moviesRated 3")
}

exports.moviesQueue= function (subscriber)
{
    console.log("moviesRated 5");

}

function actorsProf(){
    console.log ("actorsPref 4.1")
    actorsSocial("@pitt 4.2");
}

function actorsSocial(actor)
{
    console.log ("actorsSocial 4.3 "+actor)

}


