<section class="clearfix">
	<h2>View</h2>
	<a href="#/" class="btn btn-danger">back</a>


	<div class="raceTypes view">
		<div class="panel panel-default">
			<div class="panel-heading">
				<?php echo $this->Html->__t('Army Lists view'); ?>
				<span class="pull-right">
					<a href="#/edit/{{army.id}}" class="btn-sm btn-warning">Edit</a>
					<a href="#/" class="btn-sm btn-danger" ng-confirm-click="Are you sure you want to delete this army?" ng-click="submit_delete(army.id)">Delete</a>
				</span>
			</div>
			<div class="panel-body">
				<div class="row">
					<span class="col-md-3"><?php echo $this->Html->__t('Id'); ?></span>
					<span class="col-md-9">{{army.id}}</span>
				</div>
				<div class="row">
					<span class="col-md-3"><?php echo $this->Html->__t('Name'); ?></span>
					<span class="col-md-9">{{army.name}}</span>
				</div>
				<div class="row">
					<span class="col-md-3"><?php echo $this->Html->__t('Description'); ?></span>
					<span class="col-md-9">{{army.descr}}</span>
				</div>
				<div class="row">
					<span class="col-md-3"><?php echo $this->Html->__t('Point Limit'); ?></span>
					<span class="col-md-9">{{army.point_limit}}</span>
				</div>
				<div class="row">
					<span class="col-md-3"><?php echo $this->Html->__t('Hidden'); ?></span>
					<span class="col-md-9">{{army.hide}}</span>
				</div>
				<div class="row">
					<span class="col-md-3"><?php echo $this->Html->__t('Army'); ?></span>
					<span class="col-md-9">{{army.army_name}}</span>
				</div>
				<div class="row">
					<span class="col-md-3"><?php echo $this->Html->__t('Created'); ?></span>
					<span class="col-md-9">{{dateMomment(army.created)}}</span>
				</div>
				<div class="row">
					<span class="col-md-3"><?php echo $this->Html->__t('Modified'); ?></span>
					<span class="col-md-9">{{dateMomment(army.modified)}}</span>
				</div>
			</div>
		</div>
	</div>
</section>