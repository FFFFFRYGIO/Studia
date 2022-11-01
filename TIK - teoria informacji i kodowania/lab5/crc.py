x = 'qaz12345'

crc = 0xFFFFFFFF

print ("{:<15} {:<5} {:<5} {:<10}".format('crc','byte','mask','crcx'))

for byte in x:
    crcc = crc
    crc = crc ^ ord(byte)
    for i in range(8):
        mask = -(crc & 1)
        crc = (crc >> 1) ^ (0xEDB88320 & mask)
        print ("{:<15} {:<5} {:<5} {:<10}".format(crcc,byte,mask,crc))

print(~crc)
print(~crc + 2**32)
print(hex(~crc + 2**32))

print()
x = str(bin(0xEDB88320))[2:]
print(x)

for i,v in enumerate(x):
    if(i%4==0):
        print(x[i:i+4])


print('\n\n')
print(0x04C11DB7)

for i, v in enumerate(str(bin(0x04C11DB7))):
    if v:
        print(i, end=" ")