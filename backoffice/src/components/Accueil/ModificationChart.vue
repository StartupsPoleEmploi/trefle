<script>
  import { Pie } from "vue-chartjs";
  import 'chartjs-plugin-colorschemes';
  import 'chartjs-plugin-datalabels';

  export default {
    extends: Pie,
    props: ["values", 'labels'],
    watch: {
      values: {
        handler(){
          this.render();
        },
      }
    },
    methods: {
      render() {
        this.renderChart({
          labels: this.labels,
          datasets: this.values
        },{
          responsive: true,
          maintainAspectRatio:false,
          onClick:this.handle,
          plugins: {
            colorschemes: {
              scheme: 'tableau.Tableau10'
            },
            datalabels: {
              color: 'black'
            }
          },
          title: {
            text: "Répartition des modifications par fichiers"
          },
          legend: {
            position: 'right',
          }
        })
      },
      handle (point, event) {
        const item = event[0]
        this.$emit('on-receive', {
          value: this.labels[item._index].split('.')[0]
        })
      }
    },
  }
</script>