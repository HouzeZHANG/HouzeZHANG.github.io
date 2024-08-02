---
title: "Lec1: Introduction to Deep Learning"
date: 2024-08-01T19:40:49+02:00
slug: 2024-08-01-lec1
type: posts
draft: false
categories: ["MIT 6.S191"]
tags: ["Deep Learning"]
---

### Introduction to Deep Learning

- A fast changing industry
- Can revolutionize the world
- Can make hyper realistic product （超现实的）
- Can generating code from natural language

#### What is Intelligence?

- **Artificial Intelligence**: Processing information which will influence the future decision making
- **Machine Learning**: learn from data, not from rules or hard-coded logic
- **Deep Learning**: a subset of Machine Learning, using neural networks to learn from data

**Perception** is the base of neural networks

#### Why Deep Learning?

Machine learning requires hand-crafted features(not scalable, time consuming and brittle), but deep learning can learn features from data automatically

Deep learning can use GPU to parallelize the computation, such as with mini-batch gradient descent

Hardware is also important for deep learning evolution

#### Deep Learning History

- Stochastic Gradient Descent
- Perceptron: fundamental building block of deep learning
- Back propagation
- Deep convolutional neural networks

---

#### Perceptron

##### Architecture

- Elementary multiplied: 按元素相乘
  - The **feature space** is divided into two parts by the linear function of the neuron
  - The input size of the real deep learning network could be millions or billions
- **Non-linear activation function**: sigmoid, ReLU, which is used to produce the output of the neuron
  - Sigmoid function: the most common activation function(mapping to 0-1 which is used to do probability)
  - ReLU is more popular now: very fast
- Bias term: allows the neuron to shift the output in the desired direction (horizontal shift on x-axis)

##### Non-learning

Linear functions combine linear functions are still linear functions, no matter how many layers we have

Introduction of non-linear activation function is to make the model to deal with non-linear data, the world is extremely non-linear

#### Neural Network

- Hidden layer: it is called "hidden" because users cannot see the output of the hidden layer

This can increase the learning capacity of the model. The number of layers is equals to the depth of the matrix. Cascading: stack the layers one by one.

---

#### Loss Function: Whether the Model is Good or not?

*A way to train model is to calculate the loss function and back propagate the loss to the model*

Binary classification problem:

- Empirical loss: also known as objective function, loss function, cost function

![empirical loss](/6s191-lec1-empirical-loss.png)

- Cross entropy loss

![交叉熵](/6s191-lec1-bianry-cross.png)

Regression problem:

- Mean Squared Error

![MSE](/6s191-lec1-mse.png)

#### Loss Optimization

Deviation: 偏差

The mathematical model to represent the optimization of the model

![param optimization](/6s191-lec1-opti.png)

Gradient Descent:

- Compute gradient. Until we converge to the minimum point. (local minimum)
- Question: Where is the slope increasing?
- Learning rate 是一个超参数，需要调整，且很难调整
  - Not to diverge
  - Not to converge too fast

![gradient](/6s191-lec1-grad.png)

#### Back Propagation

- Use chain rule to decompose the gradient calculation into small problems
- The real training is hard
  - Large data
  - Computation-intensive
  - Long training time
  - Need a lot of data
  - Easy to overfit, derive local optimal solution

#### Adaptive learning rate

- A technique to adjust the learning rate during training
- Improve the training speed and effect
- Let the learning rate adaptively adjust

#### SGD (Stochastic Gradient Descent) and Mini-batch Gradient Descent

- When the data is too large, we can use SGD/mini-batch gradient descent
- The mini-batch size is a hyperparameter
- The mini-batch size is usually 32, 64, 128, 256, 512
- Mini-batch gradient descent is faster and better, and the small batch of data can be easily distributed to the various cores of the GPU for parallel computation

#### Over Fitting

Test whether the model is accurately capturing the true data set.

When the model performs worse on the test set(comparing with the previous train), it is over fitting

#### How to Prevent Over Fitting

- Regularization
  - Discourage the model from learning too much from the data
  - Generalize the model
- Dropout
  - Randomly drop some neurons during training: make the output of the neuron to be zero
  - Dynamically lower the capacity of the model
- Early stopping
