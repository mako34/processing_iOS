$(document).ready(function(){ 

    $("a.js").click(function(){ 
                    alert("You clicked on a link that activates javascript"); 
                    });
              
                  
});


function processImage( img )
{
    $('#testImage').remove();
    $('#body').append( '<img id="testImage" src="' + img + '" />' );
}














