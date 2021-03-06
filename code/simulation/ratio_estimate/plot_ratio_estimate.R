#plot the ratio estimate distribution
n_vec <- c(15000,75000,150000)
alpha_vec <- c(0.00,0.01,0.03,0.05)
beta_vec <- c(0,0.3,0.5,1)
setwd("/Users/zhangh24/GoogleDrive/MR_MA")
times = 100000


#i1 correponding to n
#i2 corresponding to alpha
library(ggplot2)
n.row <- length(alpha_vec)
n.col <- length(n_vec)
cover_ratio_list <- list()
cover_true_list <- list()
cover_epi_list <- list()
cover_exact_list <- list()
cover_true_exact_list <- list()
ci_low_ratio_list <- list()
ci_high_ratio_list <- list()
ci_ratio_list <- list()
ci_low_epi_list <- list()
ci_high_epi_list <- list()
ci_epi_list <- list()
ci_exact_list <- list()
ci_low_exact_list <- list()
ci_high_exact_list <- list()
cover_AR_list <- list()
ci_low_AR_list <- list()
ci_high_AR_list <- list()  
ci_AR_list <- list()
p <- list()
p_ratio <- list()
temp <- 1
load("./result/simulation/ratio_estimate/ratio_estimate_merged.Rdata")
for(i4 in 1:4){
  cover_ratio <- matrix(0,n.row,n.col)
  cover_true <- matrix(0,n.row,n.col)
  cover_epi <- matrix(0,n.row,n.col)
  cover_exact <- matrix(0,n.row,n.col)
  cover_true_exact <- matrix(0,n.row,n.col)
  ci_low_ratio <- matrix(0,n.row,n.col)
  ci_high_ratio <- matrix(0,n.row,n.col)
  ci_ratio <- matrix(0,n.row,n.col)
  ci_low_epi <- matrix(0,n.row,n.col)
  ci_high_epi <- matrix(0,n.row,n.col)
  ci_epi <- matrix(0,n.row,n.col)
  ci_exact <- matrix(0,n.row,n.col)
  ci_low_exact <- matrix(0,n.row,n.col)
  ci_high_exact <- matrix(0,n.row,n.col)
  cover_AR <- matrix(0,n.row,n.col)
  ci_low_AR <- matrix(0,n.row,n.col)
  ci_high_AR <- matrix(0,n.row,n.col)
  ci_AR <- matrix(0,n.row,n.col)
  alpha_U = 0.1
  beta_U <- 0.1
  sigma_y = 1
  sigma_m = 1
  for(i1 in 1:3){
    for(i2 in 1:4){
      # 
      # temp = 12*(i4-1)+4*(i1-1)+i2
      n <- n_vec[i1]
      alpha_G = alpha_vec[i2]
      beta_M = beta_vec[i4]
      result <- result_final[[temp]]
      Gamma = result[[1]]
      var_Gamma = result[[2]]
      gamma = result[[3]]
      var_gamma = result[[4]]
      ratio_est = result[[5]]
      var_ratio <- result[[6]]
      n <- length(Gamma)
      cover_ratio[i2,i1] <- mean(result[[7]])
      cover_true[i2,i1] <- mean(result[[8]])
      cover_epi[i2,i1] <- mean(result[[9]])
      cover_exact[i2,i1] <- mean(result[[10]])
      cover_true_exact[i2,i1] <- mean(result[[11]])
      ci_low_ratio[i2,i1] <- mean(result[[12]])
      ci_high_ratio[i2,i1] <- mean(result[[13]])
      ci_ratio[i2,i1] <- paste0(ci_low_ratio[i2,i1],", ",ci_high_ratio[i2,i1])
      ci_low_epi[i2,i1] <- mean(result[[14]])
      ci_high_epi[i2,i1] <- mean(result[[15]])
      ci_epi[i2,i1] <- paste0(round(ci_low_epi[i2,i1],2),", ",round(ci_high_epi[i2,i1],2))
      ci_low_exact[i2,i1] <- mean(result[[16]])
      ci_high_exact[i2,i1] <- mean(result[[17]])
      cover_AR[i2,i1] <- mean(result[[18]])
      ci_low_AR[i2,i1] <- mean(result[[19]])
      ci_high_AR[i2,i1] <- mean(result[[20]])
      ci_AR <- paste0(round(ci_low_AR[i2,i1],2),", ",round(ci_high_AR[i2,i1],2))
      ci_exact[i2,i1] <- paste0(round(ci_low_exact[i2,i1],2),", ",round(ci_high_exact[i2,i1],2))
      
      temp <- temp+1
    }
  }
  cover_ratio_list[[i4]] <- cover_ratio
  cover_true_list[[i4]] <-   cover_true
  cover_epi_list[[i4]] <- cover_epi
  cover_exact_list[[i4]] <- cover_exact
  cover_true_exact_list[[i4]] <- cover_true
  ci_low_ratio_list[[i4]] <- ci_low_ratio
  ci_high_ratio_list[[i4]] <- ci_high_ratio
  ci_ratio_list[[i4]] <- ci_ratio
  ci_low_epi_list[[i4]] <- ci_low_epi
  ci_high_epi_list[[i4]] <- ci_high_epi
  ci_epi_list[[i4]] <- ci_epi
  ci_exact_list[[i4]] <- ci_exact
  ci_low_exact_list[[i4]] <- ci_low_exact
  ci_high_exact_list[[i4]] <- ci_high_exact
  cover_AR_list[[i4]] <- cover_AR
  ci_low_AR_list[[i4]] <- ci_low_AR
  ci_high_AR_list[[i4]] <- ci_high_AR  
  ci_AR_list[[i4]] <- ci_AR
}

cover_epi_table <- round(rbind(cover_epi_list[[1]],
                               cover_epi_list[[2]],
                               cover_epi_list[[3]],
                               cover_epi_list[[4]]),2)
write.csv(cover_epi_table,file = "./result/simulation/ratio_estimate/cover_epi_table.csv")

cover_exact_table <- round(rbind(cover_exact_list[[1]],
                                 cover_exact_list[[2]],
                                 cover_exact_list[[3]],
                                 cover_exact_list[[4]]),2)
write.csv(cover_exact_table,file = "./result/simulation/ratio_estimate/cover_exact_table.csv")

ci_exact_table <- rbind(ci_exact_list[[1]],
                              ci_exact_list[[2]],
                              ci_exact_list[[3]],
                              ci_exact_list[[4]])
write.csv(ci_exact_table,file = "./result/simulation/ratio_estimate/ci_exact_table.csv")

cover_AR_table <- rbind(cover_AR_list[[1]],
                        cover_AR_list[[2]],
                        cover_AR_list[[3]],
                        cover_AR_list[[4]])
write.csv(cover_AR_table,file = "./result/simulation/ratio_estimate/cover_AR_table.csv")


write.csv(cover_ratio,file = "./result/simulation/ratio_estimate/cover_ratio.csv")
write.csv(cover_true,file = "./result/simulation/ratio_estimate/cover_true.csv")
write.csv(cover_epi,file = "./result/simulation/ratio_estimate/cover_epi.csv")
write.csv(cover_true_exact,file = "./result/simulation/ratio_estimate/cover_true_exact.csv")
write.csv(ci_ratio,file = "./result/simulation/ratio_estimate/ci_ratio.csv")
write.csv(ci_epi,file = "./result/simulation/ratio_estimate/ci_epi.csv")
write.csv(ci_exact,file = "./result/simulation/ratio_estimate/ci_exact.csv")


library(gridExtra)
png("./result/simulation/ratio_estimate/ratio_sd_plot.png",width = 16,height = 8,
    unit = "in",res = 300)
grid.arrange(p[[1]],p[[5]],p[[9]],
             p[[2]],p[[6]],p[[10]],
             p[[3]],p[[7]],p[[11]],
             p[[4]],p[[8]],p[[12]],
              ncol=3)
dev.off()

png("./result/simulation/ratio_estimate/ratio_sd_plot_legend.png",width = 8,height = 8,
    unit = "in",res = 300)
ggplot(data.m.temp,aes(value,colour=variable))+
  geom_density()+
  theme_Publication()
dev.off()

png("./result/simulation/ratio_estimate/ratio_plot.png",width = 16,height = 8,
    unit = "in",res = 300)
grid.arrange(p_ratio[[1]],p_ratio[[4]],p_ratio[[7]],
             p_ratio[[2]],p_ratio[[5]],p_ratio[[8]],
             p_ratio[[3]],p_ratio[[6]],p_ratio[[9]],ncol=3)
dev.off()

png("./result/simulation/ratio_estimate/ratio_plot_legend.png",width = 8,height = 8,
    unit = "in",res = 300)
temp =1 
result <- result_final[[temp]]
Gamma = result[[1]]
var_Gamma = result[[2]]
gamma = result[[3]]
var_gamma = result[[4]]
var_ratio <- result[[6]]
cover_ratio[i2,i1] <- mean(result[[8]])
cover_true[i2,i1] <- mean(result[[9]])
cover_epi[i2,i1] <- mean(result[[10]])
cover_exact[i2,i1] <- mean(result[[11]])
cover_true_exact[i2,i1] <- mean(result[[12]])
ci_low_ratio[i2,i1] <- mean(result[[13]])
ci_high_ratio[i2,i1] <- mean(result[[14]])
ci_ratio[i2,i1] <- paste0(ci_low_ratio[i2,i1],", ",ci_high_ratio[i2,i1])
ci_low_epi[i2,i1] <- mean(result[[15]])
ci_high_epi[i2,i1] <- mean(result[[16]])
ci_epi[i2,i1] <- paste0(ci_low_epi[i2,i1],", ",ci_high_epi[i2,i1])
ci_low_exact[i2,i1] <- mean(result[[17]])
ci_high_exact[i2,i1] <- mean(result[[18]])
ci_exact[i2,i1] <- paste0(ci_low_exact[i2,i1],", ",ci_high_exact[i2,i1])
ratio_est = result[[5]]
ratio_var = result[[6]]
z_est = ratio_est/sqrt(ratio_var)
standard_norm = rnorm(times)
z_Gamma <- rnorm(times)
z_gamma <- rnorm(times,mean = alpha_vec[i2]*sqrt(n_vec[i1]),sd = 1)

true_distribution <- z_Gamma/sqrt(1+z_Gamma^2/z_gamma^2)

data <- data.frame(z_est,standard_norm,true_distribution)
colnames(data) <- c("Proposed method","IVW","Empirical distribution")
library(reshape2)
data.m <- melt(data)
data.m.temp <- data.m

ggplot(data.m,aes(value,colour=variable))+
  geom_density()+
  theme_Publication()+
  theme(legend.position = "bottom")+
  theme(legend.text = element_text(face="bold"))+
  scale_fill_discrete(name = "New Legend Title")
dev.off()

