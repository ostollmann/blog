public: no
tags: [haskell, snap-framwork, web]

Snap Framework Basics
=====================

I usually develop in Python, although that has more to do with the languages look-and-feel than anything else. After almost ten years of progamming I have come to the conclusion that that is one of the most important aspects of a language. If you like static-typing use something like Java/C#, if you don't use Python or Ruby or whatever else you like. Anyway that doesn't really matter right now (although I might try to write down my thoughts about this some time). The thing is that a few months ago I first had a look at `Haskell <http://haskell.org>`_.

Haskell is a beauty. If Java is a Volswagen Golf and Python a BMW M3, then Haskell is a Porsche Carrera GT, incredible, but hard to drive. The second I finally understood what Haskell was about, I knew that it was going to become my go-to language in the future (once I get it :-). So after dabbling around for a while I thought it was time to have a look at how suited Haskell is for web development and that is where the `Snap Framework <http://snapframework.com/>`_ comes into play. From the site:

*Snap is a simple web development framework for unix systems, written in the Haskell programming language. Snap has a high level of test coverage and is well-documented.*

Installation was very easy:

.. sourcecode:: bash
    
    cabal install snap

So below are a few simple examples that I am playing with to get a hang of the framework before I can build a real project with it (already have an idea for that).

Getting the request method
--------------------------

The first thing I tried to figure out was how to get information about the request. Here is a request handler that simply prints out a requests HTTP method. With this as a basis it becomes pretty obvious how to extract other information such as the request URI, headers, etc.

.. sourcecode:: haskell

    methodHandler = do
        methodStr <- (show . rqMethod) <$> getRequest
        writeBS $ B.pack (methodStr ++ ['\n'])

