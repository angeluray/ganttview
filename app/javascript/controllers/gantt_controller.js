import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="gantt"
export default class extends Controller {
  connect() {
    const ganttData = this.element.getAttribute("data-gantt-data");

    // Displays the object 
    // console.log(ganttData);

    // Set gantt configuration and editors
    const textEditor = { type: "text", map_to: "text" };

    const startDateEditor = {
        type: "date", map_to: "start_date", min: new Date(2000, 0, 1),
        max: new Date(2024, 0, 1)
    };

    const endDateEditor = {
        type: "date", map_to: "end_date", min: new Date(2000, 0, 1),
        max: new Date(2024, 0, 1)
    };
    const durationEditor = { type: "number", map_to: "duration", min: 0, max: 100 };
    
    gantt.config.columns = [
      {name: "text", tree: true, width: '*', resize: true, editor: textEditor},
      {name: "start_date", align: "center", resize: true, editor: startDateEditor},
      {name: "end_date", label: "End Time", align: "center", resize: true, editor: endDateEditor},
      {name: "duration", align: "center", editor: durationEditor}
    ];

    gantt.config.scales = [
      {unit: "month", step: 1, format: "%F, %Y"},
      {unit: "day", step: 1, format: "%D, %j"}
    ];
    
    gantt.config.autofit = true;
    gantt.config.grid_width = 500;

    gantt.plugins({ 
      tooltip: true 
    });

    gantt.init("gantt_container");
    
    // Make an Ajax request to the controller action
    fetch(`/projects/${ganttData}.json`)
      .then((response) => {
        if (!response.ok) {
          throw new Error(`Network response was not ok: ${response.status}`);
        }
        return response.json();
      })
      .then((data) => {
        gantt.parse(data); // Receives the object of hashes
      })
      .catch((error) => {
        console.error(error);
      });
    

      gantt.attachEvent("onAfterTaskUpdate", function(id, task){
        console.log("HIIIIIIII");
        console.log(id, task)

        const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

        fetch(`/projects/${ganttData}`, {
          method: "PATCH",
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": csrfToken  // Adjust the content type if needed
          },
          body: JSON.stringify(task), // Convert data to JSON if needed
        })
        .then(response => {
          if (!response.ok) {
            console.log("Here", response)
            throw new Error("Network response was not ok");
          }
          // return response.json(); // Parse the response as JSON if needed
          return response.text();
        }).then(responseText => {
          if (responseText) {
            const responseData = JSON.parse(responseText); // Parse the response as JSON
            console.log("Success:", responseData);
          } else {
            console.log("Response data is empty");
          }
        })
        .catch(error => {
          console.error("Error:", error);
        });
        
      });
    
  }
}
