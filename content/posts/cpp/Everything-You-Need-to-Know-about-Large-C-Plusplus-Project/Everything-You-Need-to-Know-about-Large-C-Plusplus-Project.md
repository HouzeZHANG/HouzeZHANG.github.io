---
title: "Everything You Need to Know About Large C++ Project"
date: 2024-03-22T11:10:44Z
draft: true
tags: ["Visual Studio", "C++", "Toolchain"]
---

模块用文件进行表示

声明和定义的区别和关系

全局变量和局部静态变量是不同的

堆内存：程序员管理
栈空间：函数内
常数区（全局变量和局部变量的值），静态区，代码区

https://stackoverflow.com/questions/6769760/how-do-files-get-into-the-external-dependencies-in-visual-studio-c
一个是用来编译的（include目录），一个是用来给链接期链接的（外部lib）的

出现在扫描目录中的文件不一定会出现在external dependency中，后者是intelliscense算出来的，不一定严谨

Certainly! Let's delve into the concepts of **evaluated values**, **inherited values**, and **include search paths** in the context of C++ development.

1. **Evaluated Values**:
   - In a C++ project, evaluated values refer to the final configuration settings that are used during compilation and linking.
   - These values are determined by considering various factors, including project-specific overrides, inherited values, and any direct settings applied to the project.
   - When you build your project, these evaluated values are used to guide the compilation process.

2. **Inherited Values**:
   - In Visual Studio projects, certain settings can be inherited from different sources.
   - Some of these values come from settings elsewhere in your project, while others may be defined in property files (`.props` files) included in your properties hierarchy.
   - For example, if you set the project's character set to "Use Multi-byte Character Set," you'll see `_MBCS` appear in the inherited values list.
   - Additionally, there might be sneaky ways (such as directly modifying a `.props` file) that impact these inherited values.
   - To modify inherited values, consider navigating to the **Property Manager** tab and exploring the project's property hierarchy¹.

3. **Include Search Paths**:
   - When working with C/C++ projects, specifying include directories is crucial for locating header files during compilation.
   - The **Additional Include Directories** setting allows you to specify paths where the compiler should look for header files.
   - To modify this setting:
     - Find your project and open the folder for the desired configuration.
     - Right-click on **Local settings (specific for all projects in the directory)** and select **Properties**.
     - Navigate to **Common Properties** > **C/C++** > **General** and edit the **Additional Include Directories**².

Remember that property inheritance in Visual Studio projects can be complex, and understanding where and how properties are set is essential for managing your project effectively⁴. If you encounter any challenges, explore the **Property Manager** or directly modify the `.props` files as needed. Happy coding! 🚀

Source : conversation avec Bing, 3/22/2024
(1) c++ - How to change the "Inherited Values" in Property Page in Visual .... https://stackoverflow.com/questions/14533053/how-to-change-the-inherited-values-in-property-page-in-visual-studio-2012-expr.
(2) How to Find What a Project Inherit's It's Additional Include .... https://stackoverflow.com/questions/35094352/how-to-find-what-a-project-inherits-its-additional-include-directories-from.
(3) Property inheritance in Visual Studio projects - C++. https://learn.microsoft.com/en-us/cpp/build/project-property-inheritance?view=msvc-170.
(4) Visual studio 2017: Modify the inherited values - Stack Overflow. https://stackoverflow.com/questions/75198696/visual-studio-2017-modify-the-inherited-values.
(5) Visual Studio Code: How to configure includePath for better .... https://stackoverflow.com/questions/46258143/visual-studio-code-how-to-configure-includepath-for-better-intellisense-results.

## References
