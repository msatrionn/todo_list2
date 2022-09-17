<template>
  <transition data-cy="modal-success" name="modal-fade">
    <div data-cy="modal-backdrop" class="modal-backdrop">
      <div data-cy="modal-delete-success" class="modal-delete-success"
        role="dialog"
        aria-labelledby="modalTitle"
        aria-describedby="modalDescription"
      >
      <span data-cy="delete-img-container">
        <img data-cy="deleted-imgs" :src="`${SuccessDelete}`" alt="" class="delete-img" >
      </span>
      <span data-cy="infobox" class="infobox">
        Activity Berhasil DIhapus
      </span>
      </div>
    </div>
  </transition>
</template>

<style>
  .delete-img{
    width: 30px;
    margin-top: 5px;
    margin-right: 10px;
  }
  .infobox{
    display: flex;
  }
</style>

<script>
import SuccessDelete from '../assets/modal-delete-success.svg'
export default {
  name: 'SuccessDelete',
  data () {
    return {
      SuccessDelete
    }
  }
}
</script>
