message = "MJQQT! RD SFRJ NX WFIJP FSI NR KWTR UTQFSI. N QNAJ NS BFWXFB FSI XYZID NS RNQNYFWD ZSNAJWXNYD TK YJHMSTQTLD. NR F XYZIJSY TK HTRUZYJW XHNJSHJ TS YMJ KTZWYM XJRJXYJW TK XYZID. YMNX NX XTRJ YJCY BMNHM N BNQQ JSHWDUY FSI YMJS IJHWDUY BNYM F KWJVZJSHD TK FUUJFWFSHJX. N BNQQ IT NY GD F RTSTFQUMFGJYNH HNUMJW. RTSTFQUMFGJYNH HNUMJW NX F RJYMTI TK JSHWDUYNSL YJCY BNYM ZXFLJ TK FWWFSLJRJSY TK QJYYJWX NS F FQUMFGJY. BMJS DTZ BFSY YT JSHWDUY F HMFWFHYJW DTZ MFAJ YT HTSAJWY YMFY QJYYJW YT QJYYJW YMFY NX LNAJS XYJUX KZWYMJW NS FQUMFGJY. DTZ MFAJ YT STYJ YMJ KFHY YMFY YMJ HMFSLJX LTJX FX F HDHQJ."
message = message.lower()

letters = []
for i, v in enumerate(message):
    d = {'ind': i, 'char': v, 'changed': 0}
    letters.append(d)

changes = []

def print_message():
    for i in letters:
        print(i['char'], end='')
    print()

def substitute(old, new):
    print()
    print(f'changing {old} -> {new}\n')
    changes.append(" ".join([old, '->', new]))
    for i in letters:
        if not i['changed'] and i['char'] == old:
            i['char'], i['changed'] = new.upper(), 1
    print_message()
    
# Step 1: J -> E
substitute('j', 'e')

# Step 2: Y -> T
substitute('y', 't')

# Step 3: F -> A
substitute('f', 'a')

# Step 4: T -> O
substitute('t', 'o')

# Step 5: N -> I
substitute('n', 'i')

# Step 6: S -> N
substitute('s', 'n')

# Step 7: M -> H
substitute('m', 'h')

# Step 8: Q -> L
substitute('q', 'l')

# Step 9: R -> M
substitute('r', 'm')

# Step 10: X -> S
substitute('x', 's')

# Step 11: D -> Y
substitute('d', 'y')

# Step 12: I -> D
substitute('i', 'd')

# Step 13: L -> G
substitute('l', 'g')

# Step 14: H -> C
substitute('h', 'c')

# Step 15: K -> F
substitute('k', 'f')

# Step 16: U -> P
substitute('u', 'p')

# Step 17: G -> B
substitute('g', 'b')

# Step 18: W -> R
substitute('w', 'r')

# Step 19: A -> V
substitute('a', 'v')

# Step 20: Z -> U
substitute('z', 'u')

# Step 21: B -> W
substitute('b', 'w')

# Step 22: V -> Q
substitute('v', 'q')

# Step 23: C -> X
substitute('c', 'x')

# Step 24: P -> K
substitute('p', 'k')

print(changes)