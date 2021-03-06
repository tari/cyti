**CyTI is not in active development.** At this point, it is solely kept on GitHub in the hope that someone might find it interesting and move its ideas forward. For information about the features it currently supports, see the [Development Status][] page on the wiki.

**Why?** Realistically, I'm not involved in the TI calculator scene anymore. I don't have any hardware to test with beyond a TI-84+ Silver Edition, which has largely been superseded by the new CE models. CyTI itself is alpha-quality, and moving it beyond this would require investments that I'm honestly not likely to make.

Thank you for your interest, and sorry for the bad news. The CyTI README continues below, but please note that parts of it may become outdated over time.

---

What is CyTI?
=============

CyTI (pronounced "city") is a Cython module for linking with Texas Instruments (TI) graphing calculators. It presents a high-level interface to the [TiLP Framework][], including the ticables, ticalcs, tifiles, and ticonv libraries.

Basic Instructions
==================

Building CyTI
-------------

On Linux, build CyTI using distutils and setup.py:

    python3 setup.py build_ext -i

Python 3 is highly recommended, though Python 2 should work (simply use the desired Python version when running setup.py). You must have Cython installed for whichever version of Python you use. Visit [Cython][] for more information. You must also have the TiLP framework libraries (with development headers) and pkg-config. On Ubuntu, you should be able to install everything you need with:

    sudo apt-get install tilp cython3 libticables-dev libticalcs-dev libtifiles-dev libticonv-dev

Note that this will build CyTI in-place without installing it, so you must be in the CyTI directory to import it. This should be fine for playing around with the library.

Using CyTI
----------

Attach your calculator to your computer and start the Python interpreter. When you only have one calculator, connecting to it is very simple:

    import cyti
    calculator = cyti.connect()

If you have multiple calculators attached, `cyti.find_connections()` should return a list of connections. Simply find the right one and call `connect()`, similar to the above code.

With your calculator on the home screen, try running this code to make it do a simple math problem (I've occasionally had some issues, so your mileage may vary):

    for key in [0x90, 0x80, 0x90, 0x05]:
        calculator.send_key(key)

Now, try this to see what variables and apps are on your calculator:

    vars = calculator.get_file_list()
    for index, var in enumerate(vars):
        print(index, var)

The calculator is capable of storing real or complex numbers in the variables A-Z and theta. Try storing the number 42 to A by going to the home screen of your calculator and pressing (4) (2) (STO>) (ALPHA) (MATH) (ENTER). CyTI gives you easy access to this value by running the following code:

    calculator.get("number", "A")

You should see the number 42 printed in your terminal. Try storing different values to different variables and then retrieving them. Be sure to try complex numbers as well (e.g. 1+2i: (1) (+) (2) (2ND) (.) (STO>) ...).

The values of these variables on your calculator can also be set with CyTI:

    calculator.send("number", "B", -5.47)

Now, take a look at the value of B on your calculator by pressing (ALPHA) (APPS) (ENTER). You can also easily set the values of list variables:

	calculator.send("list", 1, [1, 2, 3])

Press (2ND) (1) (ENTER) to see this list appear on your calculator.

There are some other functions you can try as well:

    calculator.is_ready()        # Returns True or False
    calculator.get_id()          # Returns the unique ID reported by the calculator

<!-- Links -->
[Cython]: http://cython.org
[Development Status]: https://github.com/ahamlinman/cyti/wiki/Development-Status
[TiLP Framework]: http://lpg.ticalc.org/prj_tilp/architecture.html
