##scripts generated from Min-Lee Yang
##Function for sample matching
##Our goal is to select the 1:1 ratio of matched females for males using age and PC1-PC3, if there are more females than males in the sample file
##Input file 'example.input.txt' column: ID sex age PC1 PC2 PC3
##sex code: 1 as male, 0 as female (if females are more than males) 
##Output file: male.ID male.sex male.age  male.PC1   male.PC2   male.PC3 female.ID female.sex female.age female.PC1 female.PC2 female.PC3
##Usage:
#input=read.table('example.input.txt',header=T)
#source('match_sample_function.R')
#out.match=match_sample(input)

####Function####
match_sample<-function(file){
male1=subset(file,sex==1)
female1=subset(file,sex==0)
male1<-male1[order(male1$age),]
female1<-female1[order(female1$age),]
#
already.match.idxlist<-0  
match.name.list<-NULL
final<-NULL
for(s in 1:nrow(male1)){
if(s%%1000==0){print(s)}
age<-male1$age[s]
PC<-c(male1$PC1[s],male1$PC2[s],male1$PC3[s])

match.idx<-which(abs(female1$age-age)<=5); #find all females within 5 years old 
match.idx.remove.already.match<-match.idx[which(is.na(match(match.idx,already.match.idxlist))==T&is.na(match(female1$ID[match.idx],female1$ID[already.match.idxlist]))==T)]
if(length(match.idx.remove.already.match)<1){
	match.idx<-which(abs(female1$age-age)<=10); # if can't find age within 5 years, then find within 10 years
        match.idx.remove.already.match<-match.idx[which(is.na(match(match.idx,already.match.idxlist))==T&is.na(match(female1[match.idx,1],female1[already.match.idxlist,1]))==T)]}
if(length(match.idx.remove.already.match)>=2){ # if more than 2 females meet the matched age criteria, then select the one with the shorted PC distance
        mat.data=rep(as.numeric(PC),each=length(match.idx.remove.already.match))
		mat1 <- matrix(mat.data,nrow=length(match.idx.remove.already.match),ncol=3,byrow=FALSE) #fix a bug here
        dist.sum<-rowSums((mat1-cbind(female1$PC1,female1$PC2,female1$PC3)[match.idx.remove.already.match,])^2)
        match.idx.select<-match.idx.remove.already.match[which.min(dist.sum)]
		}else{ # if only one female meet the matched age criteria
			match.idx.select<-match.idx.remove.already.match}	
		already.match.idxlist<-c(already.match.idxlist,match.idx.select)
        match.name.list<-c(match.name.list,paste(rep(male1$ID[s],length(match.idx.select))))

	}
	

final<-unique(cbind(male1[match(match.name.list,male1$ID),1:6],female1[already.match.idxlist,1:6]))
colnames(final)[1:6]=paste('male.',colnames(final)[1:6],sep='')
colnames(final)[7:12]=paste('female.',colnames(final)[7:12],sep='')
return(final)
}
