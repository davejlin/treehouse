from django.core.urlresolvers import reverse
from django.test import TestCase
from django.utils import timezone

# Create your tests here.
from .models import Course, Step

class CourseModelTests(TestCase):
    def test_course_creation(self):
        course = Course.objects.create(
            title="Python Regular Expressions",
            description="Learn to write regular expressions in Python"
        )
        now = timezone.now()
        self.assertLess(course.created_at, now)

class StepModelTests(TestCase):
    def setUp(self):
        self.course = Course.objects.create(
            title="Python Regular Expressions",
            description="Learn to write regular expressions in Python"
        )

    def test_step_creation(self):
        step = Step.objects.create(
            title="Step 1",
            description="This is step 1",
            course = self.course
        )
        now = timezone.now()
        self.assertLess(step.course.created_at, now)

class CourseViewsTest(TestCase):
    def setUp(self):
        self.course = Course.objects.create(
            title="Python Regular Expressions",
            description="Learn to write regular expressions in Python"
        )
        self.course2 = Course.objects.create(
            title="Another course",
            description="Another Python course"
        )
        self.step = Step.objects.create(
            title="Step 1",
            description="This is step 1",
            course=self.course
        )

    def test_course_list_view(self):
        resp = self.client.get(reverse('courses:list'))
        self.assertEqual(resp.status_code, 200)
        self.assertIn(self.course, resp.context['courses'])
        self.assertIn(self.course2, resp.context['courses'])