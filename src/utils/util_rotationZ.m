function C21 = util_rotationZ(psi)
c = cos(psi);
s = sin(psi);
C21 = [c -s 0;
       s c 0
       0 0 1];