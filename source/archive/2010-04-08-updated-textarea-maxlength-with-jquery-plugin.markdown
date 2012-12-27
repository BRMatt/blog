---

title: Updated textarea maxlength with Jquery plugin
wordpress_id: 127
wordpress_url: http://sigswitch.com/?p=127
date: 2010-04-08 16:08:19.000000000 +01:00
---
When I first wrote the "Textarea maxlength with jQuery" plugin last year I had 
no idea how popular it would be - over 70% of the traffic to my site since then 
has been people reading that one post. 

The problem is, the code there is basically an ugly hack - you copy and paste 
and you're done. But if you need to implement the same functionality across a 
site with slight differences to the functionality, you'd end up with a lot of 
copy and paste garbage. So what with it being time for some spring cleaning I 
thought I'd begin by refactoring the original code into a jquery plugin:

<!-- more -->

    jQuery.fn.limitMaxlength = function(options){
    
        var settings = jQuery.extend({
            attribute: "maxlength",
            onLimit: function(){},
            onEdit: function(){}
        }, options);
    
        // Event handler to limit the textarea
        var onEdit = function(){
            var textarea = jQuery(this);
            var maxlength = parseInt(textarea.attr(settings.attribute));
    
            if(textarea.val().length > maxlength){
                textarea.val(textarea.val().substr(0, maxlength));
    
                // Call the onlimit handler within the scope of the textarea
                jQuery.proxy(settings.onLimit, this)();
            }
    
            // Call the onEdit handler within the scope of the textarea
            jQuery.proxy(settings.onEdit, this)(maxlength - textarea.val().length);
        }
    
        this.each(onEdit);
    
        return this.keyup(onEdit)
                    .keydown(onEdit)
                    .focus(onEdit)
                    .live('input paste', onEdit);
    }

And here's an example of it in use, limiting all textareas in the document and 
updating a p element with the id of charsRemaining with... the number of characters 
remaining. It also sets the textarea bg color to red when the user tries to 
exceed the maxlength.

    $(document).ready(function(){
    
        var onEditCallback = function(remaining){
            $(this).siblings('.charsRemaining').text("Characters remaining: " + remaining);
    
            if(remaining > 0){
                $(this).css('background-color', 'white');
            }
        }
    
        var onLimitCallback = function(){
            $(this).css('background-color', 'red');
        }
    
        $('textarea[maxlength]').limitMaxlength({
            onEdit: onEditCallback,
            onLimit: onLimitCallback
        });
    });

And here's a [jsbin paste with a quick demo](http://jsbin.com/ufuji3/9). 

Although there is a lot more code in this version it's a lot more flexible as it 
allows you to decide how to inform the user of how many characters there're remaining. 
It also means that it'll take any characters already in the textbox into account when the document loads. 

**Update 2010/04/09:** Fixed a few bugs & typos 

**Update 2010/08/01:** Removed problematic comma & added live('input paste') - thanks Surya and Len!