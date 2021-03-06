library(shiny)

shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({
    xmax <- 6.5
    alpha <- input$alpha
    upperend <- 1-(alpha/2)
    lowerend <- (alpha/2)
    n <- input$size
    nu <- (n-1)*2
    stdev <- input$stdev
    x1 <- seq(-3, xmax, length=100)
    m1 <- 0                       # H0
    y1 <- dt(x1, df=nu)
    x2 <- seq(-3, xmax, length=100)
    m2 <- input$mualt # Ha
    denom <- (sqrt(1/n + 1/n)* (((n-1)*1^2) + ((n-1)*stdev^2)) / (n+n-2))
    ncp <- (m2 - m1) / denom
    y2 <- dt(x2, df=nu, ncp = ncp)
    tu <- qt(upperend, df = nu)
    tl <- qt(lowerend, df = nu)
    
    plot(c(-3, xmax), c(0, max(y1)+0.015), xlab="", ylab="", 
         axes=F, type="n")
    # upper tail of shaded tail probabilities in H0
    xx1 <- seq(qt(upperend, df=nu), max(x1), length=100)
    yy1 <- dt(xx1, df = nu)
    xx1 <- c(xx1[1], xx1[1], rep(xx1[2:(length(xx1)-1)], 
                                 each=4), xx1[length(xx1)], xx1[length(xx1)])
    yy1 <- c(0, rep(t(cbind(yy1[1:(length(yy1)-1)], 0)),
                    each=2))
    yy1 <- yy1[-length(yy1)]
    polygon(x = xx1, y = yy1, density = -1, border = NA, 
            col = "grey")
    # lower tail
    xx2 <- seq(from = min(x1), to=qt(lowerend, df=nu), 
               length = 100)
    yy2 <- dt(xx2, df = nu)
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
    yy3 <- dt(xx3, df = nu, ncp = ncp)
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
    abline(v = qt(c(lowerend, upperend), df = nu))
    mtext(expression(t[u]), at = tu, adj = 0, line=0, cex = 1.5)
    mtext(expression(t[l]), at = tl, adj = 0, line=0, cex = 1.5)
    mtext(expression(H[0]), at = m1, adj = 0.5, line=0, cex = 1.5)
    mtext(expression(H[A]), at = ncp, adj = 0.5, line=0, cex = 1.5)
    mtext(bquote(delta[0] == 0), side = 1, at = 0, 
          line=3.2, cex=2.0)
    mtext(bquote(delta[a] == .(m2)), side = 1, at = ncp, 
          line=1.5, cex=2.0)
    mtext(bquote(alpha == .(alpha)), side = 1, at = -2.5, 
          line =3.2, cex = 2.0)
    pow <- 1 - pt(tu, df = nu, ncp = ncp)
    text(paste("power =", round(pow, 3)), x = ncp, 
         y = max(y2)*1.05, adj = 0.55, cex = 1.25, font = 2, col="black")
  })
})
