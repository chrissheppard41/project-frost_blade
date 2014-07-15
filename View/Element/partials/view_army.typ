<section class="clearfix">
	<article>
		<h2>View <span><a href="#/" class="back">Back</a></span></h2>
		<a href="#/" class="btn btn-danger">back</a>

		<div class="panel blue">
			<div class="panel-heading">
				<?php echo $this->Html->__t('Army Lists view'); ?>
				<span>
					<a href="#/edit/{{army.id}}" class="edit">Edit</a>
					<a href="#/" class="delete" ng-confirm-click="Are you sure you want to delete this army?" ng-click="submit_delete(army.id)">Delete</a>
				</span>
			</div>
			<div class="panel-body">
				<div class="row">
					<?php echo $this->Html->__t('Id'); ?>
					<span>{{army.id}}</span>
				</div>
				<div class="row">
					<?php echo $this->Html->__t('Name'); ?>
					<span class="col-md-9">{{army.name}}</span>
				</div>
				<div class="row">
					<?php echo $this->Html->__t('Description'); ?>
					<span class="col-md-9">{{army.descr}}</span>
				</div>
				<div class="row">
					<?php echo $this->Html->__t('Point Limit'); ?>
					<span class="col-md-9">{{army.point_limit}}</span>
				</div>
				<div class="row">
					<?php echo $this->Html->__t('Hidden'); ?>
					<span class="col-md-9">{{army.hide}}</span>
				</div>
				<div class="row">
					<?php echo $this->Html->__t('Army'); ?>
					<span class="col-md-9">{{army.army_name}}</span>
				</div>
				<div class="row">
					<?php echo $this->Html->__t('Created'); ?>
					<span class="col-md-9">{{dateMomment(army.created)}}</span>
				</div>
				<div class="row">
					<?php echo $this->Html->__t('Modified'); ?>
					<span class="col-md-9">{{dateMomment(army.modified)}}</span>
				</div>
			</div>
		</div>
	</article>
</section>