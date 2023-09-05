import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="gantt"
export default class extends Controller {
  connect() {
    // Initialize DHTMLX Gantt with your data and configurations
    gantt.init(this.element);
  }
}
