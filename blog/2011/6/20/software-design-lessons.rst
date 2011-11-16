public: yes
tags: [programming, ABB, software-design]

Software Design Lessons
=======================

During my internship at ABB Power Systems I spent most of my time developing an optimization program for a certain type of power plant. The system is a mix of C#/.Net services, VBS scripts and a control/optimization strategy based on a proprietary ABB software package (visual data/control flow programming). There are also operator reports (operator entries, trends, data stores, historical data) produced using a built-in WYSIWYG editor (that produces XHTML/JS). Now I will not go into detail about the actual product, but I thought I would share some of the key things I learnt during this project.

Lesson 0 : Reduce platform/language/tools mix:
----------------------------------------------

Building applications that rely on different components, written in different languages, running on different platforms is hard. If you can: avoid that situation. But that is hardly possible now is it? As soon as your application reaches a certain level of complexity or relies on legacy technology, developed decades ago (even if it is still maintained/updated now), you will be faced with this challenge. I guess the real lesson here is not how to deal with legacy systems, but rather that, when you develop applications you should, right from the start, think about how that application will be used years from now, but completely different people, using it to solve problems you didn't know existed when you developed it. Note that there may be situation where it is entirely adequate, if not advantageous, to build on different platforms/languages/tools, but in this case take some time to plan ahead and make your future users happy!  

Lesson 1: Build your application in a loosely-coupled style
-----------------------------------------------------------

Example: persistence; do not build an application that relies on a certain database software (like MSSQL, Oracle, etc). Separate your data model from the rest. This will allow you to change only that part of the application if you decide to change to some other persistence technology.

Lesson 2: Build application interfaces
--------------------------------------

Example: runtime hooks; structure your application in ways that will allow later/external developers to customize the application without access to the application source code. A famous example are Log4J's appenders. Another example would be services that allow you to input/output data in non-standard way; ie. a direct data access interface.

Lesson 3: Log, log, log and, finally, log some more
---------------------------------------------------

As soon as you have to use some third-party software (be it OSS, external, internal, whatever) you will run into trouble. Unless you have incredibly good documentation (not the case with most internally built tools), building systems around legacy software is incredibly hard. You have no idea what is going on. The most simple things could be the cause and you have absolutely no idea what is going on. This is even more the case when error messages look like this: ...Error: FLI-call failed. Could not write data... Logging is easy, developers log everything when they build the application and then usually turn it off for production deployments. Obviously we do not need to see debug logs all the time, but give the user the option to turn very verbose debug logging on. This will save you countless support calls and will make the developer's life much easier. It is also easier to keep your logging up-to-date than your documentation.

Lesson 4: Provide serialization options based on standard data exchange formats
-------------------------------------------------------------------------------

Everything the user enters into/produces with the software, be it complex non-linear control strategies or simple key/value sets, give him/her the option of exporting it. And I don't mean some binary dumps, I am talking about humanly-understandable text-based exports. Let it be XML/JSON/<whatever/> or (if you have to) your own data format. But let it be understandable and text-based. Providing users with some way of exporting/importing this data is invaluable. Nothing is more frustrating than repeating yourself doing dumb things. Make your user happy by letting him programatically create that import file containing 250 OPC signals instead of making him enter each and every one manually. Not only is it much easier and faster, but it is also much safer. The modus operandi here is: keep it as simple as possible, and always text-based.

Lesson 5: Do not rely on unique IDs        
-----------------------------------

This is something that makes me incredibly mad. Like insanely smashing-my-fists-on-the-desk mad. DO NOT RELY ON UNIQUE IDs. Who the hell says that they will be unique when you want to transfer something to some other system that may already contain some other items under those IDs. I know merging stuff is hard, but it is easier for the user to change names, than to change strange 38 digit IDs.

Lesson 6: Make license management painless
------------------------------------------

Do no delete a user's data when he/she changes the license. Deactivate! Don't delete! I wouldn't even hide it, just make it unusable (exportable, but unusable in the application itself). Actually, NEVER DELETE ANYTHING. Build in some deactivation logic, but don't delete someone's work under any circumstances. Ok, you don't have to be that extreme, in some cases deleting does make sense, but the motto here is: better safe than sorry.

Lesson 7: Provide command line tools
------------------------------------

This ties in a bit with lesson 2. Give user's the possibility of interacting with your application in some programmatic way. This is most important for applications that are themselves developer tools. Developers live (or should live) by the DRY principle: Don't Repeat Yourself! Nothing is more infuriating than repeating yourself over and over again because you cannot create a simple shell script that would take care of all the work in 2 nanoseconds. Time in money!

Lesson 8: Provide an option for force/override
----------------------------------------------

If I really want to send that message although the message should only be sent once a day, give me the option to force-send. These options are not going to be used by your application's normal user in a normal situation. But if I am testing the message's receiving server I may very well need to send the message two hundred times per day! Your user is hopefully smart enough to understand the consequences of what he is doing, so let him. Rules are meant to be broken J. This is especially the case when some logic depends on time. Developing a certain application, I once had a server than was running 39 hours ahead of time, because I kept having to fast-forward to the next hour, so that the application would do whatever I wanted it to do. And then guess what: the Oracle database got confused and stuffed everything up!

Recap:
======

- **Lesson 1**: Build your application in a loosely-coupled style

- **Lesson 2**: Build application interfaces

- **Lesson 3**: Log, log, log and, finally, log some more

- **Lesson 4**: Provide serialization options based on standard data exchange formats

- **Lesson 5**: Do not rely on unique IDs        

- **Lesson 6**: Make license management painless

- **Lesson 7**: Provide command line tools

- **Lesson 8**: Provide an option for force/override


There is another point which is a bit more general: **error-handling** and **system state management**. Those will have to be discussed in another post.

*Disclaimer: The opinions on this blog (http://blog.o1iver.net) are mine (Oliver Stollmann) and only mine and do not in any way reflect the views of my employer (ABB Switzerland).*

