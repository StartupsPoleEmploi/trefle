<script>
  import { Pie } from "vue-chartjs";
  import 'chartjs-plugin-colorschemes';
  import 'chartjs-plugin-datalabels';

  export default {
    extends: Pie,
    props: ["values", 'labels'],
    data : function ()  {
      return {
        test:0,
      }
    },
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
          }
        })
      },
      handle (point, event) {
        this.test = (this.test+4)*2;
        const item = event[0]
        this.$emit('on-receive', {
          value: this.labels[item._index].split('.')[0]
        })
      }
    },
  }
</script>