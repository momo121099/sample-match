# Genetic association studies 

## Function for sample matching: (1:1 ratio)

Our goal is to select the 1:1 ratio of matched females for males using age (within 5 or 10 years) and PC distance (PC1-PC3), if there are more females than males in the sample file.

### 1.Function name
>match_sample() in match_sample_function.R

Source the function file first
```
source('match_sample_function.R')
```
### 2.Input file format

> headers: ID sex age PC1 PC2 PC3

Save input file as "example.input.txt"

P.S. Input file sex code: 1 as male, 0 as female (if females are more than males) 

### 3.Output file format

> headers: male.ID male.sex male.age  male.PC1  male.PC2  male.PC3 female.ID female.sex female.age female.PC1 female.PC2 female.PC3

### 4.Example Usage:
```
input=read.table('example.input.txt',header=T)
head(input)
```

>
>ID sex age      PC1     PC2       PC3
>
>1000014   0  64 -13.6605 1.18060 -2.398320
>
>1000023   0  46 -12.4736 5.17811 -3.004340
>
>1000041   1  41 -14.2292 5.04263 -1.006930
>
>1000059   0  63 -13.3471 2.54281 -2.292290
>
>1000062   0  69 -10.8782 3.84938  0.398874
>
>1000077   1  45 -13.5644 3.30113 -2.017140


```
out.match=match_sample(input)
write.table(out.match,'match.output.txt',row.names=F,sep='\t',quote=F)

head(out.match)
```

> 
> male.ID	male.sex	male.age	male.PC1	male.PC2	male.PC3	female.ID	female.sex	female.age	female.PC1	female.PC2	female.PC3
> 
> 1000535	1	40	-13.2049	6.4793	-2.39388	1023505	0	45	-9.38811	2.7732	-2.44942
> 
> 1001882	1	40	-9.35934	4.72724	1.01743	1034723	0	45	-9.49864	2.88134	-0.825551
> 
> 1006477	1	40	-12.3727	2.67206	0.0917206	1023337	0	42	-15.9903	3.31346	-1.21669
> 
> 1008687	1	40	-13.7322	-0.0765495	-2.12107	1052920	0	43	-8.75941	1.45768	1.24736
> 
> 1012836	1	40	-10.1281	2.25592	0.319092	1036913	0	44	-9.76624	2.50383	-1.05247
> 
> 1014937	1	40	-11.6267	3.20152	-0.209592	1022843	0	42	-11.6683	3.12794	-3.51163




