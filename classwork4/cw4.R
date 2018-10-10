gmp <- read.table("https://raw.githubusercontent.com/SergeyMirvoda/MD-DA-2018/master/data/gmp.dat", header = TRUE)
gmp$pop <- gmp$gmp / gmp$pcgmp
estimate.scaling.exponent <- function(a, y0=6611, response=gmp$pcgmp,
                                      predictor = gmp$pop, maximum.iterations=100, deriv.step = 1/100,
                                      step.scale = 1e-12, stopping.deriv = 1/100) {
  mse <- function(a) { mean((response - y0*predictor^a)^2) }
  for (iteration in 1:maximum.iterations) {
    deriv <- (mse(a+deriv.step) - mse(a))/deriv.step
    a <- a - step.scale*deriv
    if (abs(deriv) <= stopping.deriv) { break() }
  }
  fit <- list(a=a,iterations=iteration,
              converged=(iteration < maximum.iterations))
  return(fit)
}
#Пример вызова с начальным занчением a
x1<-estimate.scaling.exponent(0.15)
#С помошью полученного коэффициента постройте кривую (функция curve) зависимости
y0=6611
curve(y0*x^estimate.scaling.exponent(0.15)$a^2)

#Удалите точку из набора исходных данных случайным образом, как изменилось статистическая оценка коэффициента a?
gmp <- gmp[-c(sample.int(nrow(gmp), 1))]
x2 <- estimate.scaling.exponent(0.15)
x1$a==x2$a 

#Запустите оценку несколько раз с разных стартовых точек. Как изменилось значение a?
x3 <- estimate.scaling.exponent(0,15, y0=6610)
x4 <- estimate.scaling.exponent(0,15, y0=6000)
x5 <- estimate.scaling.exponent(0,15, y0=3333)
x6 <- estimate.scaling.exponent(0,15, y0=1111)
x7 <- estimate.scaling.exponent(0,15, y0=77)
c <- (x3$a,x4$a,x5$a,x6$a,x7$a)
hist(c)
