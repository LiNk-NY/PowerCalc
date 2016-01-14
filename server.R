library(shiny)

shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({
    xmax <- 6.5
    alpha <- input$alpha
    upperend <- 1-(alpha/2)
    lowerend <- (alpha/2)
    x1 <- seq(-3, xmax, length=100)
    m1 <- input$mu                       # H0
    y1 <- dt(x1, df=98, ncp = m1)
    
    x2 <- seq(-3, xmax, length=100)
    m2 <- input$mualt # Ha
    ncp <- (m2 - m1) / sqrt(1/50 + 1/50)
    y2 <- dt(x2, df=98, ncp = ncp)
    tu <- qt(upperend, df = 98, ncp = m1)
    tl <- qt(lowerend, df = 98, ncp = m1)
    
    plot(c(-3, xmax), c(0, max(y1)), xlab="", ylab="", 
         axes=F, type="n")
    # upper tail of shaded tail probabilities in H0
    xx1 <- seq(qt(upperend, df=98, ncp = m1), max(x1), length=100)
    yy1 <- dt(xx1, df = 98, ncp = m1)
    xx1 <- c(xx1[1], xx1[1], rep(xx1[2:(length(xx1)-1)], 
                                 each=4), xx1[length(xx1)], xx1[length(xx1)])
    yy1 <- c(0, rep(t(cbind(yy1[1:(length(yy1)-1)], 0)),
                    each=2))
    yy1 <- yy1[-length(yy1)]
    polygon(x = xx1, y = yy1, density = -1, border = NA, 
            col = "grey")
    # lower tail
    xx2 <- seq(from = min(x1), to=qt(lowerend, df=98, ncp = m1), 
               length = 100)
    yy2 <- dt(xx2, df = 98, ncp = m1)
    xx2 <- c(xx2[1], xx2[1], rep(xx2[2:(length(xx2)-1)], 
                                 each=4), xx2[length(xx2)], xx2[length(xx2)])
    yy2 <- c(0, rep(t(cbind(yy2[1:(length(yy2)-1)], 0)), 
                    each=2))
    yy2 <- yy2[-length(yy2)]
    polygon(x=xx2, y=yy2, density=-1, border=NA, 
            col="grey")
    lines(x1, y1, col = "black", lwd = 3)
    abline(v = m1, lty = 2)
    # statistical power
    xx3 <- seq(from = tu, to = xmax, length = 200) # from tu and up
    yy3 <- dt(xx3, df = 98, ncp = ncp)
    xx3 <- c(xx3[1], xx3[1], rep(xx3[2:(length(xx3)-1)], 
                                 each=4), xx3[length(xx3)], xx3[length(xx3)])
    yy3 <- c(0, rep(t(cbind(yy3[1:(length(yy3)-1)], 0)), 
                    each=2))
    yy3 <- yy3[-length(yy3)]
    polygon(x=xx3, y=yy3, density=5, border=NA, 
            col="grey55")
    lines(x2, y2, col = "black", lwd = 3)
    abline(v = ncp, lty = 2)
    # labels on the x-axis
    abline(h = 0)
    abline(v = qt(c(lowerend, upperend), df = 98, ncp = m1))
    mtext(expression(t[u]), at = tu, adj = 0, line=0, cex = 1.5)
    mtext(expression(t[l]), at = tl, adj = 0, line=0, cex = 1.5)
    mtext(expression(H[0]), at = m1, adj = 0.5, line=0, cex = 1.5)
    mtext(expression(H[A]), at = ncp, adj = 0.5, line=0, cex = 1.5)
    mtext(bquote(mu[1] == .(m1)), side = 1, at = 0.5, 
          line=2, cex=2.0)
    mtext(bquote(mu[2] == .(m2)), side = 1, at = 3.5, 
          line=2, cex=2.0)
    mtext(bquote(alpha == .(alpha)), side = 1, at = -2.5, 
          line =2, cex = 2.0)
    pow <- 1 - pt(tu, df = 98, ncp = ncp)
    text(paste("power =", round(pow, 3)), x = 5.5, 
         y = max(y2), adj=1, cex=1.5, col="black")
    
    
  })
  
})
