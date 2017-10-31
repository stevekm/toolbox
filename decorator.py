#!/usr/bin/env python

'''
Demo for decorator usage
'''

class MyClass(object):
    def __init__(self, arg):
        self.arg = arg

    def do_thing_first(func, *args, **kwargs):
        def wrapper(self, *args, **kwargs) :
            print('doing another thing first')
            print('The arg is: {0}'.format(self.arg))
            func(self, *args, **kwargs)
        return(wrapper)

    @do_thing_first
    def do_thing(self, *args, **kwargs):
        print('doing the thing')
        print('args: {0}'.format(args))
        print('kwargs: {0}'.format(kwargs))

x = MyClass(1)
x.do_thing()

x.do_thing('foo', bar = 'baz')
