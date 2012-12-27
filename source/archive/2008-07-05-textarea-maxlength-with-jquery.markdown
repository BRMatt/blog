---

title: Textarea maxlength with Jquery
wordpress_id: 6
wordpress_url: http://sigswitch.com/?p=6
date: 2008-07-05 15:45:25.000000000 +01:00
---
The other day I was trying to find a way to limit the amount of characters that a user could enter into a textbox. 
For some reason you can't set the maxlength attribute on textareas, so I decided to make this little jquery snippet that truncates a user's input once they go past a certain limit. 

<!-- more -->

# There's now an updated version of this script [here](http://sigswitch.com/2010/04/updated-textarea-maxlength-with-jquery-plugin/) 

Save this snippet in a js file:

    $(document).ready(function(){
        $('textarea[maxlength]').keyup(function(){
            var max = parseInt($(this).attr(’maxlength’));
            if($(this).val().length > max){
                $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
            }
    
            $(this).parent().find('.charsRemaining').html('You have ' + (max - $(this).val().length) + ' characters remaining');
        });
    });

Just download and include [jquery](http://www.jquery.com "Jquery") like so:

    <script type="text/javascript" src="jquery.js "></script>

And then include the js file containing the above snippet Then, to limit a textarea do this:

    <textarea maxlength="255"></textarea>

If you want to show the user the 'You have x characters remaining' message, then append an element with the 'charsRemaining' class, like so:
    
    
    <p class="charsRemaining">You have 255 characters remaining</p>

You have to make sure that the p and textarea elements share the same parent, else the message won't be updated.

**UPDATE:** Thanks for the parseInt() tip [Jason](http://jasonseney.tumblr.com/)

# There's now an updated version of this script [here](http://sigswitch.com/2010/04/updated-textarea-maxlength-with-jquery-plugin/) 