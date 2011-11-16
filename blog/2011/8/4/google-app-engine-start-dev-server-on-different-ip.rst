public: yes
tags: [programming, google-app-engine]

Google AppEngine start dev server on different IP
=================================================



How do you start the development server on a different IP address (if you want to, for example, share the site across the network instead of having it run on the 127.0.0.1)? This is how:

.. sourcecode:: bash

    $ dev_appserver.py -a '10.1.2.20' .

.. image:: http://o1iver.net/media/127001.png
    :width: 250px

