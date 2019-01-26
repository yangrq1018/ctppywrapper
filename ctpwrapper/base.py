'''
Base class for Python proxy classes of C++ structures
'''

import ctypes


class Base(ctypes.Structure):
    '''
    Don't store instance of this Base, it is associated with C memory can be deallocated by C++
    '''

    def _to_bytes(self, value):
        if isinstance(value, bytes):
            return value
        else:
            # attempt to cast to string and encode as bytes
            return bytes(str(value), encoding='utf-8')

    def __repr__(self):
        '''
        repr is to be unambiguous, string is to be readable
        https://stackoverflow.com/questions/1436703/difference-between-str-and-repr
        Gives a string representation, ctypes's log is uninformative

        print out field, value pair for each field
        :return:
        '''
        items = ["%s:%s" % (item, getattr(self, item)) for (item, value) in self._fields_]
        return "%s<%s>" % (self.__class__.__name__, ",".join(items))

    def _to_string(self, value):
        if isinstance(value, bytes):
            return value.decode('GBK')
        else:
            return value

    @staticmethod
    def from_dict(d):
        return Base(**d)
