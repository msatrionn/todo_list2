<template>
  <div class="">
    <div class="home">
      <h2 class="activity">Activity</h2>
      <span data-cy="container-top" class="container-top">
        <button data-cy="button-plus" class="button-tambah" @click="createActivity">
          <div class="container-button">
            <span class="plus alt">
            </span>
            <span :style="{fontSize:'16px',paddingLeft:'6px'}">
              Tambah
            </span>
          </div>
        </button>
      </span>
    </div>
    <div class="activity" data-cy = "activity" v-if="showData == false">
      <img data-cy="img-activity" :src="`${Activity}`" alt="" class="activity-img" >
    </div>
    <div data-cy="body-content" class="body-content" v-if="showData">
      <div data-cy="square-content" class="square-content" v-for="(item,index) in showGetData.data" :key="index">
          <div data-cy="title-content" class="title-content" @click="detail(item.id)">{{item.title}}</div>
          <div  data-cy="title-date" class="title-date">
            <span data-cy="date">
              {{ item.created_at}}
            </span>
            <span data-cy="trash-button" @click="showModalDelete(item.id, item.title)" class="trash-button">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <path d="M4 7H20" stroke="#888888" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                  <path d="M10 11V17" stroke="#888888" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                  <path d="M14 11V17" stroke="#888888" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                  <path d="M5 7L6 19C6 19.5304 6.21071 20.0391 6.58579 20.4142C6.96086 20.7893 7.46957 21 8 21H16C16.5304 21 17.0391 20.7893 17.4142 20.4142C17.7893 20.0391 18 19.5304 18 19L19 7" stroke="#888888" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                  <path d="M9 7V4C9 3.73478 9.10536 3.48043 9.29289 3.29289C9.48043 3.10536 9.73478 3 10 3H14C14.2652 3 14.5196 3.10536 14.7071 3.29289C14.8946 3.48043 15 3.73478 15 4V7" stroke="#888888" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </span>
          </div>
      </div>
    </div>
  </div>
  <transition  data-cy="transition-modal" name="modal-fade" v-if="isModalVisibleDelete">
    <div class="modal-backdrop">
      <div class="modal-delete"
        role="dialog"
        aria-labelledby="modalTitle"
        aria-describedby="modalDescription"
      >
        <img :src="`${DeleteModal}`" alt="" class="delete-icon" >
        <div class="ask-modal">Apakah anda yakin menghapus List Item
          “{{getTitle}}”?
        </div>
        <div  data-cy="button-model" class="button-modal">
          <button class="button-default" @click="closeModal">Batal</button>
          <button class="button-danger" @click="deleteData(getIdForDelete)">Hapus</button>
        </div>
      </div>
    </div>
  </transition>
  <SuccessDeleted v-if="SuccessDel" @click="dellSuccess" />
</template>

<style >
  .body-content{
    width: 71%;
    margin: 0 auto;
    display: grid;
    gap: 2rem;
    grid-template-columns: repeat(auto-fit, minmax(220px, 2fr));
  }
  .square-content{
    background: #fff;
    max-width: 240px;
    height: 240px;
    border-radius: 20px;
    box-shadow: 0 3px 10px rgb(0 0 0 / 0.2);
    margin-bottom: 10px;
  }
  .container-button{
    display:flex;
    align-items:center;
    justify-content:center;
  }
  .title-content{
    cursor: pointer;
    margin-bottom: 50%;
    font-weight: bold;
    font-size: 18px;
    padding: 18px 23px;
  }
  .title-date{
    text-align: center;
    margin-top: auto;
    color: #888888;
    font-size: 14px;
    padding: 10px 25px;
    display: flex;
    align-items: center;
    justify-content: space-between;
  }
  .trash-button{
    cursor: pointer;
  }
  .detail{
    cursor: pointer;
  }
  @media(max-width: 420px){
    .button-tambah{
      margin-bottom: 20px;
    }
  }
</style>

<script>
import Activity from '../assets/activity.svg'
import DeleteModal from '../assets/modal-delete.svg'
import SuccessDeleted from '../components/SuccessDelete.vue'
import { ref, onMounted } from 'vue'
import dayjs from 'dayjs'

export default {
  name: 'HomeView',
  setup () {
    const showGetData = ref([])
    const showData = ref([])
    const requestOptions = {
      method: 'get',
      headers: { 'content-type': 'application/json' }
    }
    async function getActivityAll () {
      await fetch('https://todo.api.devcode.gethired.id/activity-groups', requestOptions).then(response => response.json()) // second step
        .then(data => {
          showGetData.value = data
          showGetData.value.data.forEach(element => {
            const date = dayjs(element.created_at)
            const getDate = date.format('D MMMM YYYY')
            element.created_at = getDate
          })
        })
      if (showGetData.value.data.length >= 1) {
        showData.value = true
      } else {
        showData.value = false
      }
    }
    onMounted(() => {
      getActivityAll()
    })
    return {
      showData,
      showGetData,
      getActivityAll
    }
  },
  data () {
    return {
      Deleted: false,
      Activity,
      getIdForDelete: '',
      DeleteModal,
      SuccessDel: false,
      isModalVisibleDelete: false
    }
  },
  components: {
    SuccessDeleted: SuccessDeleted
  },
  methods: {
    showModalDelete: function (id, title) {
      this.getIdForDelete = id
      this.getTitle = title
      this.isModalVisibleDelete = true
    },
    deleteData: async function (id) {
      const requestOptions = {
        method: 'delete',
        headers: { 'content-type': 'application/json' }
      }
      await fetch(`https://todo.api.devcode.gethired.id/activity-groups/${id}`, requestOptions).then(response => response.json()) // second step
        .then(data => {
          this.getActivityAll()
          this.isModalVisibleDelete = false
          this.SuccessDel = true
          setTimeout(() => {
            this.SuccessDel = false
          }, 1000)
        })
    },
    closeModal: function () {
      this.isModalVisibleDelete = false
    },
    close: function () {
      this.$emit('close')
    },
    createActivity: async function () {
      const requestOptions = {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ title: 'test', email: 'wow@gmail.com' })
      }
      await fetch('https://todo.api.devcode.gethired.id/activity-groups', requestOptions).then(response => response.json()) // second step
        .then(data => {
          this.getActivityAll()
        })
    },
    detail: function (id) {
      this.$router.push({
        path: '/detail',
        query: { id: id }
      })
    }
  }
}
</script>
