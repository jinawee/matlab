#include<stdio.h>
#include<math.h>

float J(float t,float t0,float sigma){
   return exp(-0.5*pow((t-t0)/sigma,2));
}

int main(int argc, char *argv[]){

    float lo=632.8e-9;
    float c=3e8;      
    float tau=lo/c;   

    float t0=20*tau;  
    float sigma=2*tau;
    float dz=lo/10;       
    float dt=dz/(2*c);    
    int nz=2000;
    float nt=1000;
    float t=0;            
    float zf=nz*dz*1e6;
    float E[nz-1];
    float H[nz-1];
    float z[nz-1];
    //Inicializa E y H
    for(int i=0;i<nz;i++){
        E[i]=0;
        H[i]=0;
        z[i]=i*dz*1e6;
    } 


    FILE * pFile;
    pFile=fopen("datos","w");
    //Empieza los calculos
    for(int n=0;n<nt;n++){
        for(int i=1;i<nz-2;i++){
            E[i]=E[i]+0.5*( H[i-1]-H[i] );
        }

        E[999]=E[999]+J(t,t0,sigma);

        for(int i=0;i<nz-2;i++){
            H[i]=H[i]+0.5*( E[i]-E[i+1] );
        }

        for(int i=0;i<nz;i++){
            fprintf(pFile,"%E ",E[i]);
        }
        //fprintf(pFile,"\n");
        t+=dt;
      }

    //Guarda los datos
    FILE * qFile;
    qFile=fopen("pos","w");
    for(int i=0;i<nz;i++){
        fprintf(qFile,"%E\n",z[i]);
    }

    //Muestra resultados
    printf("E: %.12e\n",E[999]);
    printf("t: %E\n",t);
    printf("E: %E\n",E[1000]);

    return 0;
}
