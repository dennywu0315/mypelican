Title: Markdown test
Date: 2013-3-6 16:21
Tags: Markdown
Author: DennyW


#This is a Markdown test. 
####by [DennyW](http://www.marukohome.com)

***
#This is H1
***
##This is H2
***
###This is H3
***
###Test the block quote:

>This is a block quote with two paragraphs.This is a block quote with two paragraphs.This is a block quote with two paragraphs.This is a block quote with two paragraphs.This is a block quote with two paragraphs.This is a block quote with two paragraphs.
>
>>This is nested blockquote.This is nested blockquote.This is nested blockquote.This is nested blockquote.This is nested blockquote.This is nested blockquote.

***

###Test the list:
*   Red
*   Green
*   Blue
***
1. First
2.  Second
3. Third
***
###Test code block:
This is an example of Perl script:

    foreach @array{
        my $def = $_;
        if ($def < 10){
            $def ++;
        }else{
            $def --;
        }
        print $def;
    }   

***
###Test links:
This is [an example](http://www.marukohome.com) inline link.

This is [an example] [id] reference-style link.
[id]: http://www.marukohome.com "title here"

I get 10 times more traffic from [Google] [1] than from
[Yahoo] [2] or [MSN] [3].

[1]: http://google.com/        "Google"
[2]: http://search.yahoo.com/  "Yahoo Search"
[3]: http://search.msn.com/    "MSN Search"
***

###Test the emphasize:

*Test string*

_Test string_

**Test string**

__Test string__
***

###
###Test the inline code block:
Use the `printf()` function
***

###Test the automatic link transfer:

Website: <http://marukohome.com>

Mail:<dennywu0315@gmail.com>
***

###Test Picture:
![Alt Test](http://th00.deviantart.net/fs70/150/i/2011/178/a/f/octocat_by_rstovall-d3k6a7n.jpg)

***

#Done!
###Below is the code:


    #This is a Markdown test. 
    ####by [DennyW](http://www.marukohome.com)
    
    ***
    #This is H1
    ***
    ##This is H2
    ***
    ###This is H3
    ***
    ###Test the block quote:
    
    >This is a block quote with two paragraphs.This is a block quote with two paragraphs.This is a block quote with two paragraphs.This is a block quote with two paragraphs.This is a block quote with two paragraphs.This is a block quote with two paragraphs.
    >
    >>This is nested blockquote.This is nested blockquote.This is nested blockquote.This is nested blockquote.This is nested blockquote.This is nested blockquote.
    
    ***
    
    ###Test the list:
    *   Red
    *   Green
    *   Blue
    ***
    1. First
    2.  Second
    3. Third
    ***
    ###Test code block:
    This is an example of Perl script:
    
        foreach @array{
            my $def = $_;
            if ($def < 10){
                $def ++;
            }else{
                $def --;
            }
            print $def;
        }   
    
    ***
    ###Test links:
    This is [an example](http://www.marukohome.com) inline link.
    
    This is [an example] [id] reference-style link.
    [id]: http://www.marukohome.com "title here"
    
    I get 10 times more traffic from [Google] [1] than from
    [Yahoo] [2] or [MSN] [3].
    
    [1]: http://google.com/"Google"
    [2]: http://search.yahoo.com/  "Yahoo Search"
    [3]: http://search.msn.com/"MSN Search"
    ***
    
    ###Test the emphasize:
    
    *Test string*
    
    _Test string_
    
    **Test string**
    
    __Test string__
    ***
    
    ###
    ###Test the inline code block:
    Use the `printf()` function
    ***
    
    ###Test the automatic link transfer:
    
    Website: <http://marukohome.com>
    
    Mail:<dennywu0315@gmail.com>
    ***
    
    ###Test Picture:
    ![Alt Test](http://th00.deviantart.net/fs70/150/i/2011/178/a/f/octocat_by_rstovall-d3k6a7n.jpg)
    
    ***
