# kitchen-sink
A compendium of scripts, guides, snippets and everything related to programming.

- Contains batch script that creates a *dotnet* project using the Clean architecture. It will add all the dependencies (references) as per the CLEAN architecture. Run the batch file by double clicking on it inside your repos directory.
- Contains bash script for the exact same purpose. Run the bash script with
```bash
	./solution.sh
```
in your terminal (MacOS, Linux). You will have to adjust permissions:
```bash
	chmod +x solution.sh
```

These scripts generates webapi, class libraries, adds a **README.md** file, and empty relevant *docker* files, a .gitignore for dotnet, etc..
In each script change the SOLUTION_NAME to your like.
