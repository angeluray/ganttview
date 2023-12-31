<!--

Hello, it's Angel, if you ever like to use this Readme file as a template let me suggest son required sections, feel free to remove the ones that are not listed if you want.

REQUIRED SECTIONS:
- Table of Contents
- About the Project
  - Built With
  - Live Demo
- Getting Started
- Authors
- Future Features
- Contributing
- Show your support
- Acknowledgements
- License

OPTIONAL SECTIONS:
- FAQ

-->

<!-- <div align="center">
<!-- Angel logo section -->
<!-- </div> -->

<!-- TABLE OF CONTENTS -->

# 📗 Table of Contents

- [📖 About the Project](#about-project)
  - [🛠 Built With](#built-with)
    - [Tech Stack](#tech-stack)
    - [Key Features](#key-features)
- [💻 Getting Started](#getting-started)
  - [Setup](#setup)
  - [Prerequisites](#prerequisites)
  - [Install](#install)
  - [Usage](#usage)
- [👥 Authors](#authors)
- [📝 License](#license)

<!-- PROJECT DESCRIPTION -->

# 📖 Gantt Project Visualizer <a name="about-project"></a>
The live site is currently having issues [Gantt Project Visualizer](https://gantt-mawi.onrender.com). but feel free to watch the video introduction to the Gantt viewer by [clicking here](https://youtu.be/VE6bBFkAMYc).

Have a great day and happy coding :) - Angel

# ERD(Entity Relationship Diagram)
![image](https://github.com/angeluray/ganttview/assets/97189760/874c79ac-2c28-414a-8487-815c89e3f934)


## 🛠 Built With <a name="built-with"></a>

### Tech Stack <a name="tech-stack"></a>

<details>
  <summary>Server and Client</summary>
  <ul>
    <li><a href="https://rubyonrails.org/">Ruby on Rails 7</a></li>
    <li><a href="https://rubyonrails.org/">Stimulus</a></li>
    <li><a href="https://rubyonrails.org/">Turbo</a></li>
    <li><a href="https://rubyonrails.org/">Tailwind</a></li>
  </ul>
</details>

<details>
<summary>Database</summary>
  <ul>
    <li><a href="https://www.postgresql.org/">PostgreSQL 15</a></li>
  </ul>
</details>

<!-- Features -->

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## 💻 Getting Started <a name="getting-started"></a>

To get a local copy up and running, follow these steps.

### Prerequisites

In order to run this project you need at least the following versions of:

`Ruby 2.7.0, 3.x, 4.x 5.x 6`
`Ruby on Rails 7.x`
`PostgreSQL ^12`

### Setup

Clone this repository to your desired folder:


Example commands:

```bash
  cd my-folder
  git clone https://github.com/angeluray/ganttview.git
```

### Install

Install this project with:

````bash
bundle install
````
> Configure the database by setting your `username` and `password` in the required fields within the database.yml then run the following series of commands:

````bash
  rails db:create
````

````bash
  rails db:migrate
````

````bash
  rails db:seed
````
>  You are good to go, now you can start the server by running:

````bash
  rails s
````

_Note 1:_To be able to make the app work properly you should have Java installed in your PC since MPXJ(the gem that reads and extract data from .mpp files) is written and maintained in Java. You can check their documentation [right here](https://www.mpxj.org/)_.

_Note 2:_ _There are not tests implemented currently for this Gantt project viewer, however the features were built considering most of the edge cases within the time interval for completing the project, I am open to suggestions for future improvements_.

_Note 3:_ _According to [DHTMLX Javascript library](https://dhtmlx.com/), this library uses a non-inclusive time format for displaying the tasks, meaning that if a project goal starts on Saturday 9 and Finishes on Sunday 10 it count it as 1 day goal not a 2 days one. Therefore I increased +1 the projects'goals_.

_Note 4:_ _Turbo-frames helped to edit as well the name of a project in-line, try it and let me know your suggestions_.

![image_2023-09-09_08-22-41](https://github.com/angeluray/ganttview/assets/97189760/4717433d-6097-4566-b52b-673f35772e65)

![image_2023-09-09_08-22-58](https://github.com/angeluray/ganttview/assets/97189760/453a8e06-441d-450a-963d-8293bd2e73e2)

_Note 5:_ _Eevery task's cell is editable as long as they are task_.


<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- AUTHORS -->

## 👥 Authors <a name="authors"></a>

- GitHub: [@angeluray](https://github.com/angeluray)
- LinkedIn: [LinkedIn](https://www.linkedin.com/in/angeluray-jobs/)


## 📝 License <a name="license"></a>

This project is [MIT](./LICENSE) licensed.

