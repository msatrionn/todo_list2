<template>
  <div>
    <div class="home" data-cy="detail">
      <span class="inputActivity">
        <span class="back-button" data-cy="back-button">
          <router-link to="/home" data-cy="to-home">
           <svg width="35" height="35" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M6.66675 16L14.6667 24" stroke="#111111" stroke-width="5" stroke-linecap="square"/>
            <path d="M6.66675 16L14.6667 8" stroke="#111111" stroke-width="5" stroke-linecap="square"/>
          </svg>
          </router-link>
        </span>
        <span data-cy="title-new" class="title-new-activity" v-if="isActive">{{ showGetOne.title }}</span>
        <span data-cy="active" v-if="isActive == false">
          <input type="text" data-cy="update-change" class="input-data" :value="showGetOne.title " @input="text = $event.target.value" autofocus @change="updateChange()">
        </span>
        <span @click="editActivity" class="editActivity" data-cy="editActivity">
          <img :src="`${Edit}`" alt="" class="action-svg-img" data-cy="img-edit">
        </span>
      </span>
       <span class="container-top" data-cy="container-top">
        <button data-cy="button" class="button-filter" @click="showCard()">
          <div data-cy="plus" class="container-button">
            <div class=""  data-cy="svg-btn">
              <svg width="22" data-cy="figma-first" height="20" viewBox="0 0 22 14" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M2 6L6 2M6 2L10 6M6 2V16" stroke="#888888" stroke-width="1.5" stroke-linecap="square"/>
                <path d="M20 12L16 16M16 16L12 12M16 16V2" stroke="#888888" stroke-width="1.5" stroke-linecap="square"/>
              </svg>
            </div>
          </div>
        </button>
        <div class="card-sort" v-if="sort_card" data-cy="card-sort">
          <div data-cy="sort-list" class="sort-list" @click="terbaru(1)"><img :src="`${New}`" alt="" class="action-svg-img list-icon">Terbaru <span class="check-class" v-if="check == 1"><img :src="Check" alt="" srcset=""></span></div>
          <div data-cy="sort-list" class="sort-list" @click="terlama(2)"><img :src="`${Last}`" alt="" class="action-svg-img list-icon">Terlama <span class="check-class" v-if="check == 2"><img :src="Check" alt="" srcset=""></span></div>
          <div data-cy="sort-list" class="sort-list" @click="aToZFilter(3)"><img :src="`${aToZ}`" alt="" class="action-svg-img list-icon" >A-Z <span class="check-class" v-if="check == 3"><img :src="Check" alt="" srcset=""></span></div>
          <div data-cy="sort-list" class="sort-list" @click="zToAFilter(4)"><img :src="`${zToA}`" alt="" class="action-svg-img list-icon">Z-A <span class="check-class" v-if="check == 4"><img :src="Check" alt="" srcset=""></span></div>
          <div data-cy="sort-list" class="sort-list" @click="BelumSelesai(5)"><img :src="`${Yet}`" alt="" class="action-svg-img list-icon" >Belum Selesai <span class="check-class" v-if="check == 5"><img :src="Check" alt="" srcset=""></span></div>
        </div>
        <button data-cy="button" class="button-tambah" @click="showModal">
          <div data-cy="plus" class="container-button">
            <span class="plus alt" data-cy="plus-alt">
            </span>
            <span data-cy="pluss" :style="{fontSize:'16px',paddingLeft:'6px'}">
              Tambah
            </span>
          </div>
        </button>
       </span>
    </div>
    <div class="activity" data-cy ="activity" v-if="showData == false">
      <img :src="`${Activity}`" alt="" data-cy="activity-img" class="activity-img" >
    </div>
    <div data-cy="list-container" class="list-container">
      <div data-cy="list" class="list" v-for="(item, index) in showGetData" :key="index">
       <span data-cy="inner-list" class="inner-list">
          <label data-cy="container-check" class="container-checkbox">
            <input data-cy="checkbox" type="checkbox">
            <span data-cy="bench" class="checkmark"></span>
          </label>
          <span data-cy="contents" class="center-content list-content">
              <span data-cy="color" class="color" :style="`${item.priority}` == 'very-high'
              ? {background:'#ed4c5c'} : `${item.priority}` == 'high'
              ? {background:'#f8a540'} : `${item.priority}` == 'normal'
              ? {background:'#00a790'} : `${item.priority}` == 'low'
              ? {background:'#418bc1'} : `${item.priority}` == 'very-low'
              ? {background:'#8942c1'} : ''"></span>
              <span data-cy="name-content" class="name-content">{{ item.title }} {{ item.id }}</span>
              <img data-cy="action-svg" :src="`${Edit}`" alt="" class="action-svg-img" @click="showModalEdit(item.id, item)">
          </span>
       </span>
       <span data-cy="trash-content" class="center-content trash">
          <img data-cy="trash-img" :src="`${Delete}`" alt="" class="action-svg-img" @click="showModalDelete(item.id, item.title)">
       </span>
      </div>
    </div>

    <!-- modal -->
  <transition data-cy="modals" name="modal-fade" v-if="isModalVisible">
    <div data-cy="modal-back" class="modal-backdrop">
      <div data-cy="modal-common" class="modal"
        role="dialog"
        aria-labelledby="modalTitle"
        aria-describedby="modalDescription"
      >
        <header
          data-cy="modal-head"
          class="modal-header"
          id="modalTitle"
        >
          <slot name="header" data-cy="header">
            Tambah List Item
          </slot>
          <button
            data-cy="button-close"
            type="button"
            class="btn-close"
            @click="closeModal"
            aria-label="Close modal"
          >
            x
          </button>
        </header>

        <section
          data-cy="modal-body"
          class="modal-body"
          id="modalDescription"
        >
          <slot name="body" data-cy="body-out">
            <form action="" data-cy="forms">
              <label for="" data-cy="nama-list">NAMA LIST ITEM</label>
              <input type="text" class="input-modal" name="" v-model="createText" id="" placeholder="Tambahkan nama list item" @keyup="buttonSaveCheck()">
              <label for="" data-cy="label-priority">PRIORITY</label>
              <CustomSelect
                :options="[{'color':'#ed4c5c', 'priority':'very-high', 'caption':'Very High'}, {'color':'#f8a540','priority':'high','caption':'High'},{'color':'#00a790','priority':'normal','caption':'Medium'},{'color':'#418bc1','priority':'low','caption':'Low'},{'color':'#8942c1','priority':'very-low','caption':'Very Low'}]"
                class="select-custom"
                @input="customColor"
                data-cy="custom-select"
              />
            </form>
          </slot>
        </section>

        <footer class="modal-footer" data-cy="modal-footer">
          <slot name="footer" data-cy="footer">
            <div class="footer-modal-inner" data-cy="footer-moddal">
                <button data-cy="button" class="button-tambah" @click="showModal" v-if="valCreate">
                  <div data-cy="plus" class="container-button">
                    <span data-cy="create-list" :style="{fontSize:'16px',paddingLeft:'6px'}" @click="createList()">
                      Simpan
                    </span>
                  </div>
                </button>
                <button data-cy="button" class="button-tambah-disabled" @click="showModal" v-if="!valCreate">
                  <div data-cy="plus" class="container-button">
                     <span data-cy="btn-new" :style="{fontSize:'16px',paddingLeft:'6px'}"  v-if="!valCreate" class="saveBtn">
                      Simpan
                    </span>
                  </div>
                </button>
            </div>
          </slot>
        </footer>
      </div>
    </div>
  </transition>

  <transition data-cy="transition-modal" name="modal-fade" v-if="isModalVisibleEdit">
    <div class="modal-backdrop" data-cy="backdrop-modal">
      <div class="modal"
        data-cy="titlenew"
        role="dialog"
        aria-labelledby="modalTitle"
        aria-describedby="modalDescription"
      >
        <header
          data-cy="modal-header"
          class="modal-header"
          id="modalTitle"
        >
          <slot name="header"
          data-cy="header">
            Edit List Item
          </slot>
          <button
            data-cy="btn-close"
            type="button"
            class="btn-close"
            @click="closeModal"
            aria-label="Close modal"
          >
            x
          </button>
        </header>

        <section
          data-cy="modal-body"
          class="modal-body"
          id="modalDescription"
        >
          <slot name="body" data-cy="modal-header"
          >
            <form action="">
              <label for="">NAMA LIST ITEM</label>
                <input type="text" class="input-modal" :value="showTitle " @input="createText = $event.target.value" autofocus placeholder="Tambahkan nama list item"  @change="buttonSaveCheck()">
              <label for="">PRIORITY</label>
              <CustomSelect
                :options="[{'color':'#ed4c5c', 'priority':'very-high', 'caption':'Very High'}, {'color':'#f8a540','priority':'high','caption':'High'},{'color':'#00a790','priority':'normal','caption':'Medium'},{'color':'#418bc1','priority':'low','caption':'Low'},{'color':'#8942c1','priority':'very-low','caption':'Very Low'}]"
                class="select-custom"
                @input="customColor"
              />
            </form>
          </slot>
        </section>
        <footer class="modal-footer">
          <slot name="footer">
            <div class="footer-modal-inner">
                <button data-cy="button" class="button-tambah" @click="showModal" v-if="valCreate">
                  <div data-cy="plus" class="container-button">
                    <span :style="{fontSize:'16px',paddingLeft:'6px'}" @click="updateList(getEditId)">
                      Simpan
                    </span>
                  </div>
                </button>
                <button data-cy="button" class="button-tambah-disabled" @click="showModal" v-if="!valCreate">
                  <div data-cy="plus" class="container-button">
                     <span :style="{fontSize:'16px',paddingLeft:'6px'}"  v-if="!valCreate" class="saveBtn">
                      Simpan
                    </span>
                  </div>
                </button>
            </div>
          </slot>
        </footer>
      </div>
    </div>
  </transition>
    <!-- <div id="app">
      <Modal
        :data-vol = "cek"
        v-show="isModalVisible"
        @close="closeModal"
      />
    </div> -->
  </div>
  <transition data-cy = "modal-fade" name="modal-fade" v-if="isModalVisibleDelete">
    <div data-cy = "modal-backdrop" class="modal-backdrop">
      <div data-cy = "modal-delete" class="modal-delete"
        role="dialog"
        aria-labelledby="modalTitle"
        aria-describedby="modalDescription"
      >
        <img data-cy = "delete-icon" :src="`${DeleteModal}`" alt="" class="delete-icon" >
        <div data-cy = "ask-modal" class="ask-modal">Apakah anda yakin menghapus List Item
          “{{getTitle}}”?
        </div>
        <div data-cy="button-modal" class="button-modal">
          <button data-cy="button-default" class="button-default" @click="closeModal">Batal</button>
          <button data-cy="button-danger" class="button-danger" @click="deleteData(getIdForDelete)">Hapus</button>
        </div>
      </div>
    </div>
  </transition>
  <SuccessDeleted data-cy="success-deleted" v-if="SuccessDel" @click="dellSuccess" />
</template>

<style>
.inputActivity{
  margin-top: 25px;
  font-size: 36px;
  width: 350px;
  font-weight: 700;
  margin-right: 20px;
  left: 0;
  display: flex;
  align-items: center;
}
.isActive{
  display: block;
}
.editActivity{
  cursor: pointer;
}
input[class=input-data] {
  height: 46px;
  width: 100%;
  background: transparent;
  border: none;
  color: black;
  font-family: "Poppins",sans-serif;
  font-size: 36px;
  font-weight: 700;
  border-bottom: 1px solid #000000;
}
input[class=input-data]:focus{
  outline: none;
}
.back-button{
  margin-top: 7px;
}
/* input{
} */
.list-container{
  width: 71%;
  margin: 0 auto;
  margin-top: 50px;
}

.list-container .list {
  margin-bottom: 10px;
  background: #fff;
  width: 100%;
  height: 80px;
  border-radius: 15px;
  display: flex;
  justify-content: space-between;
  box-shadow: 0 3px 10px rgb(0 0 0 / 0.2);
}

.inner-list{
  width: 400px;
}

.container-checkbox {
  display: block;
  position: relative;
  padding-left: 35px;
  margin-top: 26px;
  margin-left: 26px;
  margin-bottom: 12px;
  cursor: pointer;
  font-size: 22px;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
}

/* Hide the browser's default checkbox */
.container-checkbox input {
  position: absolute;
  opacity: 0;
  cursor: pointer;
  height: 0;
  width: 0;
}

/* Create a custom checkbox */
.checkmark {
  position: absolute;
  top: 0;
  left: 0;
  height: 24px;
  width: 24px;
  background-color: #fff;
  border: 1px solid #C7C7C7;
}

/* On mouse-over, add a grey background color */
.container-checkbox:hover input ~ .checkmark {
  background-color: #ccc;
}

/* When the checkbox is checked, add a blue background */
.container-checkbox input:checked ~ .checkmark {
  background-color: #2196F3;
}

/* Create the checkmark/indicator (hidden when not checked) */
.checkmark:after {
  content: "";
  position: absolute;
  display: none;
}

/* Show the checkmark when checked */
.container-checkbox input:checked ~ .checkmark:after {
  display: block;
}

/* Style the checkmark/indicator */
.container-checkbox .checkmark:after {
  left: 9px;
  top: 5px;
  width: 5px;
  height: 10px;
  border: solid white;
  border-width: 0 3px 3px 0;
  -webkit-transform: rotate(45deg);
  -ms-transform: rotate(45deg);
  transform: rotate(45deg);
}
.center-content{
  margin-top: 26px;
  margin-left: 70px;
}
.trash{
  margin-right: 30px;
}
.list-content{
  display: flex;
  align-items: center;
}

.name-content{
  margin: 0 20px;
  font-weight: 600;
  font-size: 18px;
}
.title-new-activity{
  margin-right: 10px;
}
input[class=input-modal]{
  width: 97.5%;
  margin-top: 20px;
  margin-bottom: 20px;
  padding: 14px 0;
  font-weight: 400;
  border: 1.5px solid #E5E5E5;
  border-radius: 5px;
  font-size: 16px;
  padding-left: 20px;
  padding-top: 15px;

}
input[class=input-modal]::placeholder{
  font-family: "Poppins",sans-serif;
  font-size: 16px;
  font-weight: 400;
}

.card-sort{
  z-index: 999999;
  position: absolute;
  margin-top: 5px;
  background: #fff;
  box-shadow: 0 3px 10px rgb(0 0 0 / 0.2);
  width: 250px;
  border-radius: 8px;
}

.sort-list{
  cursor: pointer;
  display: flex;
  align-items: center;
  padding: 15px;
  padding-left: 20px;
  border-bottom: 1px solid #ccc;
}
.list-icon{
  margin-right: 15px;
}
.check-class{
    margin-left: auto;
}
</style>

<script>
import Activity from '../assets/detail.svg'
import Edit from '../assets/edit.svg'
import Delete from '../assets/delete.svg'
import Sort from '../assets/sort.svg'
import DeleteModal from '../assets/modal-delete.svg'
import aToZ from '../assets/sort/a-z.svg'
import zToA from '../assets/sort/z-a.svg'
import New from '../assets/sort/terbaru.svg'
import Last from '../assets/sort/terlama.svg'
import Yet from '../assets/sort/belum.svg'
import CustomSelect from '../components/CustomSelect.vue'
import SuccessDeleted from '../components/SuccessDelete.vue'
import Check from '../assets/check.svg'
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'

export default {
  name: 'HomeView',
  setup () {
    const showGetData = ref([])
    const showData = ref([])
    const showGetOne = ref([])
    const getQueryParam = ref('')
    const requestOptions = {
      method: 'get',
      headers: { 'content-type': 'application/json' }
    }
    const route = useRoute()
    const showQueryParams = route.query.id
    getQueryParam.value = showQueryParams
    async function getOneActivity () {
      const requestOptions = {
        method: 'get',
        headers: { 'content-type': 'application/json' }
      }
      await fetch(`https://todo.api.devcode.gethired.id/activity-groups/${showQueryParams}`, requestOptions).then(response => response.json()) // second step
        .then(data => {
          showGetOne.value = data
        })
    }
    async function getActivityAll () {
      await fetch(`https://todo.api.devcode.gethired.id/todo-items?activity_group_id=${showQueryParams}`, requestOptions).then(response => response.json()) // second step
        .then(data => {
          showGetData.value = data.data
        })
      if (showGetData.value.length >= 1) {
        showData.value = true
      } else {
        showData.value = false
      }
    }
    onMounted(() => {
      getActivityAll()
      getOneActivity()
    })
    return {
      Check,
      showData,
      showGetOne,
      showGetData,
      getQueryParam,
      getActivityAll,
      getOneActivity
    }
  },
  data () {
    return {
      Activity,
      Edit,
      Delete,
      showTitle: '',
      Sort,
      aToZ,
      zToA,
      New,
      Last,
      DeleteModal,
      Yet,
      check: '',
      getEditId: '',
      SuccessDel: false,
      getIdForDelete: '',
      getPriority: 'very-high',
      valCreate: false,
      sort_card: false,
      isModalVisibleDelete: false,
      isModalVisible: false,
      isModalVisibleEdit: false,
      isActive: true,
      createText: '',
      getTitle: ''
    }
  },
  components: {
    CustomSelect,
    SuccessDeleted
  },
  methods: {
    customColor: function (n) {
      this.getPriority = n
    },
    terlama: async function (n) {
      this.check = n
      const requestOptions = {
        method: 'get',
        headers: { 'content-type': 'application/json' }
      }
      await fetch(`https://todo.api.devcode.gethired.id/todo-items?activity_group_id=${this.getQueryParam}`, requestOptions).then(response => response.json()) // second step
        .then(data => {
          this.showGetData = data.data.reverse()
          this.sort_card = false
        })
    },
    terbaru: async function (n) {
      this.check = n
      const requestOptions = {
        method: 'get',
        headers: { 'content-type': 'application/json' }
      }
      await fetch(`https://todo.api.devcode.gethired.id/todo-items?activity_group_id=${this.getQueryParam}`, requestOptions).then(response => response.json()) // second step
        .then(data => {
          this.showGetData = data.data.sort((a, b) => b.created_at - a.created_at)
          this.sort_card = false
        })
    },
    aToZFilter: async function (n) {
      this.check = n
      function compare (a, b) {
        if (a.title < b.title) {
          return -1
        }
        if (a.title > b.title) {
          return 1
        }
        return 0
      }
      this.showGetData = this.showGetData.sort(compare)
      this.sort_card = false
    },
    zToAFilter: async function (n) {
      this.check = n
      function compare (a, b) {
        if (a.title > b.title) {
          return -1
        }
        if (a.title < b.title) {
          return 1
        }
        return 0
      }
      this.showGetData = this.showGetData.sort(compare)
      this.sort_card = false
    },
    BelumSelesai: function (n) {
      console.log(n)
      this.sort_card = false
    },
    buttonSaveCheck: function () {
      if (this.createText) {
        this.valCreate = true
      } else {
        this.valCreate = false
      }
    },
    showModalDelete: function (id, title) {
      this.getIdForDelete = id
      this.isModalVisibleDelete = true
      this.getTitle = title
    },
    editActivity: function () {
      this.isActive = !this.isActive
    },
    showModal: function () {
      this.isModalVisible = true
    },
    closeModal: function () {
      this.isModalVisible = false
      this.isModalVisibleEdit = false
      this.isModalVisibleDelete = false
    },
    showModalEdit: function (P, item) {
      this.getEditId = P
      this.showTitle = item.title
      this.isModalVisibleEdit = true
    },
    close: function () {
      this.$emit('close')
    },
    showCard: function () {
      this.sort_card = !this.sort_card
    },
    createList: function () {
      const Text = this.createText
      console.log(this.getPriority)
      const requestOptions = {
        method: 'post',
        headers: { 'content-type': 'application/json' },
        body: JSON.stringify({ title: Text, activity_group_id: this.getQueryParam, priority: this.getPriority })
      }
      fetch('https://todo.api.devcode.gethired.id/todo-items', requestOptions).then(response => response.json()) // second step
        .then(data => {
          this.getActivityAll()
          this.getOneActivity()
          this.isModalVisible = false
          this.getPriority = 'very-high'
        })
    },
    updateList: function (id) {
      const Text = this.createText
      const requestOptions = {
        method: 'PUT',
        headers: { 'content-type': 'application/json' },
        body: JSON.stringify({ title: Text, priority: this.getPriority, is_active: 1, activity_group_id: this.getQueryParam, created_at: Date.now(), updated_at: Date.now() })
      }
      fetch(`https://todo.api.devcode.gethired.id/todo-items/${id}`, requestOptions).then(response => response.json()) // second step
        .then(data => {
          this.getActivityAll()
          this.getOneActivity()
          this.isModalVisible = false
          this.isModalVisibleEdit = false
        })
    },
    deleteData: function (id) {
      const requestOptions = {
        method: 'delete',
        headers: { 'content-type': 'application/json' }
      }
      fetch(`https://todo.api.devcode.gethired.id/todo-items/${id}`, requestOptions).then(response => response.json()) // second step
        .then(data => {
          this.getActivityAll()
          this.getOneActivity()
          this.isModalVisibleDelete = false
          this.SuccessDel = true
          setTimeout(() => {
            this.SuccessDel = false
          }, 1000)
        })
    },
    dellSuccess: function () {
      this.SuccessDel = false
    },
    updateChange: async function () {
      const requestOptions = {
        method: 'put',
        headers: { 'content-type': 'application/json' },
        body: JSON.stringify({ title: this.text, created_at: Date.now(), updated_at: Date.now() })
      }
      await fetch(`https://todo.api.devcode.gethired.id/activity-groups/${this.getQueryParam}`, requestOptions).then(response => response.json()) // second step
        .then(data => {
          this.getActivityAll()
          this.getOneActivity()
        })
    }
  }
}
</script>
