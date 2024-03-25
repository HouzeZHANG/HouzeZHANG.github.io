---
title: "Quantitative Method M1"
date: 2024-03-25T21:50:40+01:00
draft: true
tags: ["Quantitative Method"]
---

## 利率 Interest Rate

利率*interest rate*的本质是资金的价格。理解利率可以通过三个维度：必要回报率*required rate of return*，折现率*discount rate*以及机会成本*opportunity cost*。

必要回报率指投资时的回报率不应低于利率，否则不如将资金存入银行来的划算。此外，利率体现了货币的时间价值，可以用利率将远期价格折现到现价（现实中计算现价需要对未来的利率进行估计），是沟通现价和远期价格的桥梁，利率因此会从这个角度影响资产估值。最后，机会成本的解释则是站在投资者*investor*的角度看的，如果投资者将钱贷给了别人，则意味着放弃了其他的投资机会，不能赚到的最多的钱等于机会成本（此处暗指将钱存入银行）。

$$
名义利率 = 名义无风险利率 + 风险溢价\\
名义无风险利率 = 实际无风险利率 + 通货膨胀率（溢价）\\
风险溢价 = 违约风险溢价 + 流动性风险溢价 + 期限风险溢价
$$


*nominal interest rate* 名义利率
*nominal risk free interest rate* 名义无风险利率
*real risk free interest rate* 实际无风险利率
*risk premium* 风险溢价
*inflation rate(premium)* 通货膨胀率
*default risk premium* 违约风险溢价
*liquidity premium* 流动性风险溢价
*maturity premium* 期限风险溢价

对于借贷双方，融资成本和投资收益一体两面。

## 回报率 Rate of Returns

### 持有期间回报率 Holding Period Return

$$
HPR = \frac{(P_{end} - P_{start} + Income_{end})}{P_{begin}}
$$

Return in **single specific period** of time.

- $Income_{end}$为投资股票时获得的现金股利*cash dividend*或投资债券时获得的债券票息*coupon*。
- 本模型不考虑各个持有期的长短，各个持有期可以不等长。

由货币的时间价值属性：
$$
Income_{start} \ge Income_{middle} \ge Income_{end}
$$

得到：
$$
HPR_{Income\_start} = \frac{(P_{end} - P_{start} + Income_{start})}{P_{begin}} \\
\ge HPR_{Income\_middle} = \frac{(P_{end} - P_{start} + Income_{middle})}{P_{begin}} \\
\ge HPR = \frac{(P_{end} - P_{start} + Income_{end})}{P_{begin}}
$$

### 整体回报率（复利模型）Total Return (Compounded model)

$$
1+R_{total} = \prod_{i = 1}^{n} {(1+HPR_{i})}
$$

本模型不考虑各个持有期的长短，各个持有期可以不等长。

### 平均回报率 Five Mean Return

平均回报率的公式均为对本利和求平均

#### 算数平均回报率

用于计算单利下的平均回报率

$$
1+R_{arithmetic} = \frac{1}{n} \sum_{i=1}^{n}(1+R_i) \\
R_{arithmetic} = \frac{1}{n} \sum_{i=1}^{n}R_i
$$

#### 几何平均回报率

用于计算复利下的平均回报率。

$$
{(1+R_{geometric})}^{n} = {\prod_{i=1}^{n}(1+R_{i})}
$$

该公式形式和复利模式的整体回报率如出一辙。

$$
R_{geometric} = \sqrt[n]{\prod_{i=1}^{n}(1+R_{i})}-1
$$

## References