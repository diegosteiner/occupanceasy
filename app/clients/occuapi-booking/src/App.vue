<template>
  <div id="app">
    <img src="./assets/logo.png">
    <router-view></router-view>
    <a v-on:click="getOccupancies">{{ test }}</a>
  </div>
</template>

<script>
import JsonApi from 'devour-client'

export default {
  name: 'app',
  data () {
    return {
      id: '2284b78a-d4b1-418f-8eca-5fae213db0a1',
      test: 'test'
    }
  },
  methods: {
    getOccupancies: function () {
      let component = this
      let api = new JsonApi({ apiUrl: 'http://localhost:3000/api/v1' })
      api.define('occupiable', {
        id: '',
        description: '',
        bookings: {
          jsonApi: 'hasMany',
          type: 'booking'
        }
      })
      api.define('booking', {
        id: '',
        begins_at: '',
        ends_at: ''
      })

      api.find('occupiable', this.id).then(value => {
        console.log(value)
      }, reason => {
        console.log('oh no!')
        console.log(reason)
      })
      component.test = 'toast'
    }
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
