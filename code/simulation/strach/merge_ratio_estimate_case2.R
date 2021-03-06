#Get the coverage probability for single ratio distribution
#Ratio estimate
args = commandArgs(trailingOnly = T)
i1 = as.numeric(args[[1]])
i2 = as.numeric(args[[2]])
i3 = as.numeric(args[[3]])
setwd("/data/zhangh24/MR_MA/")

n_vec <- c(15000,75000,150000)
beta_vec <- c(0)

times = 1000*50
n <- n_vec[i1]
MAF =0.25
cover_epi <- rep(0,times)
G_ori = matrix(rbinom(n*5,1,MAF),n,1)
G = apply(G_ori,2,scale)
for(i1 in 1:3){
  for(i2 in 1){
    Gamma_est <- rep(0,times)
    Gamma_var <- rep(0,times)
    gamma_est <- rep(0,times)
    gamma_var <- rep(0,times)
    ratio_est <- rep(0,times)
    ratio_var <- rep(0,times)
    ratio_cover <- rep(0,times)
    total <- 0
    for(i3 in 1:50){
      load(paste0("./result/simulation/ratio_estimate_case2",i1,"_",i2,"_",i3,".Rdata"))
      temp <- length(result[[1]])
      Gamma_est[total+(1:temp)] <- result[[1]]
      Gamma_var[total+(1:temp)] <- result[[2]]
      gamma_est [total+(1:temp)] <- result[[3]]
      gamma_var[total+(1:temp)] <- result[[4]]
      ratio_est[total+(1:temp)] <- result[[5]]
  result <- list(Gamma_est,
                     Gamma_var,
                     gamma_est,
                     gamma_var,
                     ratio_est,
                     ratio_var,
                     ratio_cover,
                     cover_ratio,
                     cover_true,
                     cover_epi)
      
      }
  }
}

  
  #print(i)
  beta_M = 0
  beta_G = beta_vec[i2]
  sigma_y = 1
  sigma_m = 1
  M = G%*%beta_G+rnorm(n,sd = sqrt(sigma_m))
  Y = rnorm(n,sd = sqrt(sigma_y))
  est <- Regression(Y,M,G)
  Gamma_est[i] <- est[1]
  Gamma_var[i] <- est[2]
  gamma_est[i] <- est[3]
  gamma_var[i] <- est[4]
  ratio_temp <- Ratio(est[1],est[2],est[3],est[4],n)
  ratio_est[i] <- ratio_temp[1]
  ratio_var[i] <- ratio_temp[2]
  cover_epi[i] <- ratio_temp[3]
}

z_est <- ratio_est/sqrt(ratio_var)
standard_norm <- rnorm(times)
z_Gamma <- rnorm(times)
z_gamma <- rnorm(times,mean = beta_G*sqrt(n),sd = 1)

true_distribution <- z_Gamma/sqrt(1+z_Gamma^2/z_gamma^2)
p_est <- 2*pnorm(-abs(z_est))
cover_ratio <- 1-sum(p_est<=0.05)/times

q_result <- quantile(true_distribution,c(0.025,0.975))
cover_vec = ifelse(z_est>=q_result[1]&
                     z_est<=q_result[2],1,0)

cover_true <- sum(cover_vec)/length(cover_vec)
cover_epi <- sum(cover_epi)/length(cover_epi)

save(result,file = paste0("./result/simulation/ratio_estimate_case2",i1,"_",i2,"_",i3,".Rdata"))





# library(ggplot2)
# data <- data.frame(z_est,standard_norm,true_distribution)
# colnames(data) <- c("Ratio","Standard Normal","Derived_distribution")
# library(reshape2)
# data.m <- melt(data)
# ggplot(data.m,aes(value,colour=variable))+
#   geom_density()+
#   theme_Publication()




