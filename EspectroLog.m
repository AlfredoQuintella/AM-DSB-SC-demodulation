function Espectro=EspectroLog(Fs,x)

X=fft(x); 
N=size(X,1);

Nn=floor(N/2);

EspectrNeg=X((Nn+2):N,:);

EspectrPos=X(1:(Nn+1),:);

Espectr=[EspectrNeg; EspectrPos];

Espectr=abs(Espectr);
Deltaf=Fs/N;
f=(-Deltaf*size(EspectrNeg,1)):Deltaf:(Deltaf*(size(EspectrPos,1)-1));
semilogy(f,Espectr);grid
